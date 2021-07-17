# frozen_string_literal: true

class TermsAndCondition
  attr_accessor :header, :body, :footer, :clauses, :sections

  def initialize(header, body, footer, clauses, sections)
    @header = "#{header}\n\nThis document is made of plaintext.\n"
    @body = body
    @footer = "\n#{footer}"
    @clauses = clauses
    @sections = sections
  end

  def process_body
    processed_body = []

    body.each do |bod|
      processed_body << "Is made of #{handle_tags(bod)}\n"
    end

    processed_body.join
  end

  def handle_tags(tag)
    split_tag = tag.split('-')
    case split_tag[0]
    when 'CLAUSE'
      "#{find_clause(split_tag[1])[0][:text]}."
    when 'SECTION'
      section_clauses = []
      find_section(split_tag[1]).each do |sec|
        section_clauses << sec[:text]
      end
      "#{section_clauses.join(';')}."
    end
  end

  def find_clause(id)
    clause_array = []

    clauses.each do |clause|
      clause_array << clause if clause[:id].eql? id.to_i
    end

    clause_array
  end

  def find_section(id)
    section_array = []

    sections.each do |section|
      section_array << section if section[:id].eql? id.to_i
    end

    clauses = []
    section_array[0][:clauses_ids].each do |clause_id|
      clauses << find_clause(clause_id)
    end

    clauses.flatten
  end

  def display
    "#{header}#{process_body}#{footer}"
  end
end
