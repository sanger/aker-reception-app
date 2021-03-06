import EnzymeHelper from '../enzyme_helper'

import React, { Fragment } from 'react';
import { expect } from 'chai'
import { shallow, mount } from 'enzyme';
import { createMockStore } from 'redux-test-utils';

import MappingTool from "../../../../app/javascript/react/components/mapping_tool.jsx"

const getContext = (status) => {
  let context = { store: createMockStore(status) };
  return { context }
}

describe('<MappingTool />', () => {

  let status = {
    "manifest": {
      "manifest_id": "1234",
      "labwares": [
        {"supplier_plate_name": "Labware 1","positions": ["A:1","B:1"]},
        {"supplier_plate_name": "Labware 2","positions": ["1"]}
      ]
    },
    mapping: {
      hasUnmatched: true,
      expected: [
        'tissue',
        'phenotype'],
      observed: ['Tissue', 'concentration', 'volume'],
      matched: [
        {expected: 'taxId', observed: 'taxonomy id'},
        {expected: 'sampleName', observed: 'samplename'}
      ]
    },
    schema: {
      properties: {
        taxId: { friendly_name: "Taxon id", required: true},
        sampleName: { friendly_name: "Sample Name", required: true},
        tissue: { friendly_name: "Tissue", required: true},
        phenotype: { friendly_name: "Phenotype", required: true},
      }
    }
  }

  context('when rendering it', () => {
    let wrapper = mount(<MappingTool />, getContext(status))
    it('renders the MappingInterface element', () => {
      expect(wrapper.find('MappingInterface')).to.have.length(1)
    })
    it('renders the MappedFieldsList element', () => {
      expect(wrapper.find('MappedFieldsList')).to.have.length(1)
    })
    it('renders the list of fields mapped from the status', () => {
      expect(wrapper.find('MappedFieldsList').find('MappedPairs').find('tr')).to.have.length(2)
    })
    it('renders the MappingInterface element', () => {
      expect(wrapper.find('MappingInterface')).to.have.length(1)
    })
    it('renders the list of observed fields', () => {
      expect(wrapper.find('MappingInterface').find('ExpectedMappingOptions').find('option')).to.have.length(2)
    })
    it('renders the list of expected fields', () => {
      expect(wrapper.find('MappingInterface').find('ObservedMappingOptions').find('option')).to.have.length(3)
    })
  })
})
