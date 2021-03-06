# This service is responsible for creating a new MaterialReception
# and updating all materials in labwares to available: true
class ReceptionService

  delegate :presenter, to: :material_reception

  attr_reader :labware, :material_reception

  def initialize(args)
    @labware = args.fetch(:labware)
  end

  def process
    # Python eve date format currently defaults to the RFC1123 standard: a, %d %b %Y %H:%M:%S GMT
    format = Time.now.strftime('%a, %d %b %Y %T GMT')
    begin
      ActiveRecord::Base.transaction do
        material_reception.save!
        material_ids.each { |mid|
          MatconClient::Material.new(_id: mid).update_attributes(available: true, date_of_receipt: format)
        }
      end
    rescue Faraday::ConnectionFailed, MatconClient::Errors::ApiError => e
      material_reception.errors[:base] << 'Labware could not be received at this time.'
      return false
    rescue
      return false
    else
      return true
    end
  end

  def material_reception
    @material_reception ||= MaterialReception.new(labware: labware)
  end

private

  def material_ids
    labware&.contents&.values.flat_map { |bio_data| bio_data['id'] }
  end

end

