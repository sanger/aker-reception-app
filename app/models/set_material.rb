require 'set_service_client'

class SetMaterial
	# include SetMaterialClient
	include ActiveModel::Model

	validates :name, presence: true	

	attr_accessor :uuid, :name

	def self.create_remote_set(submission_id)
	  	create SetServiceClient.post(submission_id)
	end

	def self.add_materials_to_set(set_uuid, materials)
		SetServiceClient.add_materials(set_uuid, materials)
	end

	def self.get_remote_set_with_materials(set_uuid)
		SetServiceClient.get_with_materials(set_uuid)
	end

	private 

	def self.create(obj)
	  	new filter(obj)
	end

	def self.filter(h)
		{:uuid => h["data"]["id"], :name => h["data"]["attributes"]["name"]}
	end

end