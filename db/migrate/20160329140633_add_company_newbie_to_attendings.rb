class AddCompanyNewbieToAttendings < ActiveRecord::Migration
  def change
    add_column :attendings, :company_newbie, :boolean
  end
end
