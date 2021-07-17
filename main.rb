# frozen_string_literal: true

require_relative 'terms_and_condition.rb'

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

t_and_c = TermsAndCondition.new(header, body, footer, clauses, sections)
t_and_c.process_body
puts t_and_c.display
