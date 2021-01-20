# frozen_string_literal: true

require 'spec_helper'

describe 'postgresql_userconfig::passfile_entry' do
  let(:title) { 'namevar' }
  let(:params) do
    { targets: 'postgresql' }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it {
        is_expected.to contain_concat__fragment(title + ' postgresql')
          .with_target('postgresql')
          .with_order('100')
      }
    end
  end
end
