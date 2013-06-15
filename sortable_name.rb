# -*- encoding : utf-8 -*-
class SortableName

  POSTNOMINALS = %w(PhD. BS SR JR esq sen. jun. I II III JEG2).map!(&:upcase)
  HONORIFICS = /Mr?s?\./

  def initialize name=nil
    raise 'Computer says, no.' if name.nil?
    parse @unformatted = name.strip
  end

  def to_s sortable=true
    sortable ? format_sortable : format_original
  end

  private

  attr_reader :parts, :names

  def parse name
    @parts         = name.split(/\s+/)
    @names         = arrange_names(name_parts_only)
  end

  def name_parts_only
    parts - honorifics - post_nominals
  end

  def format_sortable
    [ names, post_nominals ].join(' ').strip
  end

  def post_nominals
    @post_nominals ||=  parts.select { |p| POSTNOMINALS.include?(p.upcase) }
  end

  def honorifics
    @honorifics ||= parts.select { |p|  p =~ HONORIFICS }
  end

  def arrange_names(_names)
    (_names.count > 2 ? last_part_first(_names) : _names.reverse).join(", ")
  end

  def last_part_first(_names)
    [ _names.last, _names[0..-2].join(' ') ]
  end

  def format_original
    @unformatted.split(/\s+/).join(' ')
  end

end


