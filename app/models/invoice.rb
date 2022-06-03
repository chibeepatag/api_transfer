class Invoice
  require 'json'
  INVOICE_ATTRS = ["tax_exempt", "salesman_id", "reference", "payments", "user_id", "tax_inclusive", "invoice_extra_charges", "customer_id", "invoice_lines", "remark", "invoice_tax_rates", "customer", "parent", "customer_name"]
  
  # Method to prepare JSON for C3 Post Requests
  def prepare_data c4_json
    reqs = []
    JSON.parse(c4_json).each do |e|
      inv = Hash.new
      entry = Hash.new
      INVOICE_ATTRS.each do |t|
        case t
          when 'invoice_lines'
            entry[t] = nested_handlers(e[t], 'invoice_lines')
          when 'payments'
            entry[t] = nested_handlers(e[t], 'payments')
          when 'customer'
            entry[t] = customer_handler(e[t])
          when 'invoice_tax_rates'
            entry[t] = nested_handlers(e[t], 'invoice_tax_rates')
          else
            if t == 'user_id'
              entry[t] = nil
            else
              entry[t] = e[t]
            end
        end
      end
    inv['invoice'] = entry
    reqs.push(inv.to_json)
    end
    print reqs
    return reqs
  end

  def nest_attrs(data_type)
    case data_type
      when 'invoice_lines'
        return ["subtotal", "line_no", "discount_text", "product_id", "remark", "price", "quantity",  "retail_price"]
      when 'payments'
        return ["payment_type_id", "tender", "amount"]
      when 'customer'
        return ["utc_updated_at", "tax_exempt", "gender", "fax", "mobile", "status", "country", "street", "first_name", "company_name", "tin", "name", "membership_expired_at", "birthday", "zipcode", "last_name", "customer_type_id", "telephone", "remark", "code", "available_points", "utc_created_at", "city", "state", "email", "alternate_code"]
      when 'invoice_tax_rates'
        return ["amount", "rate"]
    end
  end
  
  def nested_handlers(nested_array, data_type)
    entries = []
    nested_array.each do |e|
      entry_hash = Hash.new
      self.nest_attrs(data_type).each do |attr|
        entry_hash[attr] = e[attr]
      end
      entries.push(entry_hash)
    end
    return entries
  end
  
  def customer_handler(customer)
    entry_hash = Hash.new
    self.nest_attrs('customer').each do |customer_attr|
      entry_hash[customer_attr] = customer[customer_attr]
    end
    return entry_hash
  end
end