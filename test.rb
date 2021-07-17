# frozen_literal: true

require 'minitest/autorun'
require_relative 'terms_and_condition.rb'

class TestTermsAndCondition < Minitest::Test
  def setup
    header = 'A T&C Document'
    body = ['CLAUSE-3', 'CLAUSE-4', 'SECTION-1']
    footer = 'Your legals.'

    clauses = [
      {'id': 1, 'text': 'The quick brown fox'},
      {'id': 2, 'text': 'jumps over the lazy dog'},
      {'id': 3, 'text': 'And dies'},
      {'id': 4, 'text': 'The white horse is white'}
    ]
    sections = [
      { "id": 1, "clauses_ids": [1, 2] }
    ]

    @t_and_c = TermsAndCondition.new(header, body, footer, clauses, sections)
    @t_and_c.process_body
  end

  def test_example_template
    expected = "A T&C Document\n\n" \
      "This document is made of plaintext.\n" \
      "Is made of And dies.\n" \
      "Is made of The white horse is white.\n" \
      "Is made of The quick brown fox;jumps over the lazy dog.\n" \
      "\nYour legals."
    
    assert_equal expected, @t_and_c.display
  end
end
