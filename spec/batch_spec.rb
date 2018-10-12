require 'spec_helper'

describe BatchedRelations::Batch do
  before(:each) do
    Thing.delete_all
  end

  describe "#next_batch_relation" do
    it "returns <limit> number of results" do
      things = 3.times.map { |i| Thing.create! }
      batch = BatchedRelations::Batch.new(relation: Thing.all.limit(2), order: [:id])
      relation = batch.next_relation_after(nil)

      expect(relation.count).to eq(2)
    end

    it "orders by the provided order attributes" do
      batch = BatchedRelations::Batch.new(relation: Thing.all, order: [:id])
      relation = batch.next_relation_after(nil)

      expect(relation.order_values.map(&:to_sql).join(', ')).to eq('"things"."id" ASC')
    end

    describe "with single ordering attribute" do
      it "constrains to after the last seen value" do
        batch = BatchedRelations::Batch.new(relation: Thing.all, order: [:id])

        relation = batch.next_relation_after({id: 1})

        expect(relation.where_clause.send(:predicates).map(&:to_sql)).to include('"things"."id" > 1')
      end
    end
  end
end
