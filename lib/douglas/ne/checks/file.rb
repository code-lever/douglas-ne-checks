require 'nokogiri'
require 'open-uri'

module Douglas; module NE; module Checks

  class File

    attr_reader :dump

    def initialize(uri)

      doc = Nokogiri::HTML(open(uri))

      title = doc.at_xpath('//discotitlexhtml')

      table = doc.at_xpath('//body/table')
      header = table.children[0]

      @dump = {}

      fund_rows = 0
      fund = nil
      org_rows = 0
      org = nil
      table.children.each_with_index do |row, idx|
        next if idx == 0 || idx == table.children.length - 1

        cols = row.children
        if cols.last.text.include? 'TOTAL'
          fund_rows -= 1
          next
        end

        offset = 0
        if fund_rows <= 0
          fund_rows = cols[0]['rowspan'].to_i
          fund = cols[0].text.strip
          @dump[fund] = {}
          offset += 1
        end

        if org_rows == 0
          org_rows = cols[0 + offset]['rowspan'].to_i
          org = cols[0 + offset].text.strip
          @dump[fund][org] = []
          offset += 1
        end

        #puts "[#{idx}]: #{fund_rows},#{org_rows} #{cols.length}"

        rest = cols.drop(offset)
        supplier, account, description, invoice, check_number, check_date, check_status, amount = rest.map(&:text)

        @dump[fund][org] << {
          supplier: supplier,
          account: account,
          description: description,
          invoice: invoice,
          check_number: check_number.to_i,
          check_date: check_date,
          check_status: check_status,
          amount: amount.gsub(/,/, '').to_f,
        }

        fund_rows -= 1
        org_rows -= 1

      end

    end

  end

end; end; end
