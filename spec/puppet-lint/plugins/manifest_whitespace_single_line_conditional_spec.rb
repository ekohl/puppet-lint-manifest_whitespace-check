# frozen_string_literal: true

require 'spec_helper'

describe 'manifest_whitespace_single_line_conditional' do
  let(:code) { "$groups = if $sudo { ['wheel'] } else { [] }" }

  it 'should detect a no problem' do
    expect(problems).to be_empty
  end
end
