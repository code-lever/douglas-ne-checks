require 'nokogiri'
require 'open-uri'

module Douglas; module NE; module Checks

  class File

    attr_reader :raw_data

    def initialize(uri)

      @raw_data = { funds: [] }

      # open the file and snag the two main elements
      doc = Nokogiri::HTML(open(uri))
      title = doc.at_xpath('//discotitlexhtml')
      table = doc.at_xpath('//body/table')

      # initialize the state tracking variables
      fund_rows = 0
      fund = nil
      org_rows = 0
      org = nil

      table.children.each_with_index do |row, idx|

        # first row is a header
        next if idx == 0

        cols = row.children

        # rows with TOTAL don't include useful data
        if cols.last.text.include? 'TOTAL'
          fund_rows -= 1
          next
        end

        # first cell has number of rows for the fund, if we're not already in one
        offset = 0
        if fund_rows <= 0
          fund_rows = cols[0]['rowspan'].to_i
          org_rows = 0
          fund = cols[0].text.strip
          @raw_data[:funds] << { name: fund, organizations: [] }
          offset += 1
        end

        # second cell has number of rows for the organization, if we're not already in one
        if org_rows == 0
          org_rows = cols[0 + offset]['rowspan'].to_i
          org = cols[0 + offset].text.strip
          @raw_data[:funds].last[:organizations] << { name: org, entries: [] }
          offset += 1
        end

        # finally, data, pick it all out!
        values = cols.drop(offset).map(&:text)
        @raw_data[:funds].last[:organizations].last[:entries] << {
          supplier: values[0],
          account: values[1],
          description: values[2],
          invoice: values[3],
          check_number: values[4].to_i,
          check_date: Date.parse(values[5]),
          check_status: values[6],
          amount: values[7].gsub(/,/, '').to_f,
        }

        fund_rows -= 1
        org_rows -= 1

      end

    rescue
      raise ArgumentError, 'File does not appear to be a Supplier Checks Report by Department report'
    end

    def fund_names
      @raw_data[:funds].map { |f| f[:name] }
    end

    def fund(name)
      @raw_data[:funds].find { |f| f[:name] == name }
    end

  end

end; end; end
