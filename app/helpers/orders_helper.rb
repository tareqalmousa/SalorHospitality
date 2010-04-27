module OrdersHelper

  def compose_item_label(input)
    if input.class == Quantity
      label = "#{ input.article.name }<br><small>#{ input.price } EUR, #{ input.name }</small>"
    else
      label = "#{ input.name }<br><small>#{ input.price } EUR</small>"
    end
    return label
  end

  def switch_item_js_code
    %{
      function mark_item(list_id, order_id, item_id) {
        if ( $('order_items_attributes_'+order_id+'_'+item_id+'_partial_order').value == 1 ) {
          list_id.style.backgroundColor = 'white';
          $('order_items_attributes_'+order_id+'_'+item_id+'_partial_order').value = 0;
        } else {
          list_id.style.backgroundColor = '#CCC';
          $('order_items_attributes_'+order_id+'_'+item_id+'_partial_order').value = 1;
        }
     }
   }
  end


  def download_invoice_js
    "Event.observe(window, 'load',
      function() {
        location.href='#{order_path(@order)}.bon';
      }
    );"
  end

  def generate_js_variables
    @designator = 'DESIGNATOR'
    @sort = 'SORT'
    @articleid = 'ARTICLEID'
    @quantityid = 'QUANTITYID'
    @price = 'PRICE'
    @label = 'LABEL'
    @count = 1

    new_item_html = render 'items/item', :locals => { :sort => @sort, :articleid => @articleid, :quantityid => @quantityid, :label => @label, :designator => @designator, :count => @count, :price => @price }
    new_item_html_var = "\n\nvar new_item_html = \"#{ escape_javascript new_item_html }\""

    return  new_item_html_var
  end

end
