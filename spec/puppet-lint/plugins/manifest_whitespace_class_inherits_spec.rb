# frozen_string_literal: true

require 'spec_helper'

describe 'manifest_whitespace_inherits_name_single_space_before' do
  let(:single_space_msg) { 'there should be a single space between the inherits statement and the name' }

  context 'with two spaces' do
    let(:code) do
      <<~EOF
        # example
        #
        # Main class, includes all other classes.
        #

        class example inherits  other::example {
          class { 'example2':
            param1 => 'value1',
          }
        }
      EOF
    end

    context 'with fix disabled' do
      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a error' do
        expect(problems).to contain_error(single_space_msg).on_line(6).in_column(23)
      end
    end

    context 'with fix enabled' do
      before do
        PuppetLint.configuration.fix = true
      end

      after do
        PuppetLint.configuration.fix = false
      end

      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should fix the manifest' do
        expect(problems).to contain_fixed(single_space_msg)
      end

      it 'should fix the space' do
        expect(manifest).to eq(
          <<~EOF,
            # example
            #
            # Main class, includes all other classes.
            #

            class example inherits other::example {
              class { 'example2':
                param1 => 'value1',
              }
            }
          EOF
        )
      end
    end
  end
end

describe 'manifest_whitespace_inherits_name_single_space_after' do
  let(:single_space_msg) { 'there should be a single space between the class or resource name and the first bracket' }

  context 'with no spaces' do
    let(:code) do
      <<~EOF
        # example
        #
        # Main class, includes all other classes.
        #

        class example inherits other::example{
          class  { 'example2':
            param1 => 'value1',
          }
        }
      EOF
    end

    context 'with fix disabled' do
      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a error' do
        expect(problems).to contain_error(single_space_msg).on_line(6).in_column(38)
      end
    end

    context 'with fix enabled' do
      before do
        PuppetLint.configuration.fix = true
      end

      after do
        PuppetLint.configuration.fix = false
      end

      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should fix the manifest' do
        expect(problems).to contain_fixed(single_space_msg)
      end

      it 'should fix the newline' do
        expect(manifest).to eq(
          <<~EOF,
            # example
            #
            # Main class, includes all other classes.
            #

            class example inherits other::example {
              class  { 'example2':
                param1 => 'value1',
              }
            }
          EOF
        )
      end
    end
  end

  context 'with two spaces' do
    let(:code) do
      <<~EOF
        # example
        #
        # Main class, includes all other classes.
        #

        class example inherits other::example  {
          class  { 'example2':
            param1 => 'value1',
          }
        }
      EOF
    end

    context 'with fix disabled' do
      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a error' do
        expect(problems).to contain_error(single_space_msg).on_line(6).in_column(38)
      end
    end

    context 'with fix enabled' do
      before do
        PuppetLint.configuration.fix = true
      end

      after do
        PuppetLint.configuration.fix = false
      end

      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should fix the manifest' do
        expect(problems).to contain_fixed(single_space_msg)
      end

      it 'should fix the space' do
        expect(manifest).to eq(
          <<~EOF,
            # example
            #
            # Main class, includes all other classes.
            #

            class example inherits other::example {
              class  { 'example2':
                param1 => 'value1',
              }
            }
          EOF
        )
      end
    end
  end

  context 'with newline' do
    let(:code) do
      <<~EOF
        # example
        #
        # Main class, includes all other classes.
        #

        class example inherits other::example


          {
          class  { 'example2':
            param1 => 'value1',
          }
        }
      EOF
    end

    context 'with fix disabled' do
      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a error' do
        expect(problems).to contain_error(single_space_msg).on_line(6).in_column(38)
      end
    end

    context 'with fix enabled' do
      before do
        PuppetLint.configuration.fix = true
      end

      after do
        PuppetLint.configuration.fix = false
      end

      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should fix the manifest' do
        expect(problems).to contain_fixed(single_space_msg)
      end

      it 'should fix the newline' do
        expect(manifest).to eq(
          <<~EOF,
            # example
            #
            # Main class, includes all other classes.
            #

            class example inherits other::example {
              class  { 'example2':
                param1 => 'value1',
              }
            }
          EOF
        )
      end
    end
  end

  context 'with comment' do
    let(:code) do
      <<~EOF
        # example
        #
        # Main class, includes all other classes.
        #

        class example inherits other::example # the class
        {
          class  { 'example2':
            param1 => 'value1',
          }
        }
      EOF
    end

    context 'with fix disabled' do
      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a error' do
        expect(problems).to contain_error(single_space_msg).on_line(6).in_column(38)
      end
    end

    context 'with fix enabled' do
      before do
        PuppetLint.configuration.fix = true
      end

      after do
        PuppetLint.configuration.fix = false
      end

      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should not fix the manifest' do
        expect(problems).to contain_error(single_space_msg).on_line(6).in_column(38)
      end
    end
  end
end
