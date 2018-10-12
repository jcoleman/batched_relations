class BatchedRelations::Batch
  attr_reader :relation
  attr_reader :order

  def initialize(relation:, order:)
    @relation = relation
    @order = order

    # TODO: raise if order already applied?
    # TODO: raise unless limit applied?
    # TODO: raise unless valid index?
  end

  def next_relation_after(last_values_by_order_attribute)
    next_relation = self.relation.order(self.order)
    if last_values_by_order_attribute
      self.order.each do |order_attribute|
        # TODO: this only handles single ordering attributes.
        arel = self.relation
          .model
          .arel_table[order_attribute]
          .gt(last_values_by_order_attribute.fetch(order_attribute))
        next_relation = next_relation.where(arel)
      end
      # TODO: ordering needs to handle nulls unless NOT NULL
    end
    next_relation
  end
end
