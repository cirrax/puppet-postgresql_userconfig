# frozen_string_literal: true

require 'spec_helper'

describe 'postgresql_userconfig::passfile' do
  let(:title) { 'namevar' }
  let(:params) do
    {
      filepath: '/tmp',
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it {
        is_expected.to contain_concat(title)
          .with_owner(title)
          .with_mode('0600')
          .with_path('/tmp/.pgpass')
      }

      it {
        is_expected.to contain_concat__fragment(title + ' header')
          .with_target(title)
          .with_order('000')
      }
    end
  end
end
