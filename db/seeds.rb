# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Bank.delete_all
Flight.destroy_all
Squawk.delete_all

banks_hash = [{name: "LKAA", min: "1401", max: "1477"},{name: "LKAA_DOM", min: "3352", max: "3377"},{name: "LKAA_WEST", min: "6620", max: "6637"},
              {name: "LKTB_CTA", min: "3320", max: "3325"}, {name: "LKMT_CTA", min: "3345", max: "3347"},
              {name: "LKPR", min: "3310", max: "3317"}, {name: "LKTB", min: "4320", max: "4327"}, {name: "LKMT", min: "4330", max: "4337"},
              {name: "LKKV", min: "3305", max: "3307"}, {name: "LKPD", min: "7020", max: "7027"}, {name: "LKVO", min: "3301", max: "3304"},
              {name: "LKCV", min: "7040", max: "7047"}, {name: "LKNA", min: "7010", max: "7017"}, {name: "LKKB", min: "7070", max: "7077"},
              {name: "LKAA_VFR", min: "3330", max: "3344"}, {name: "LKAA_MAN", min: "5170", max: "5177"},
              {name: "LKTB_EXT", min: "3326", max: "3327"}]
banks_hash.each do |bank|
	banka = Bank.new
	banka.min = bank[:min]
	banka.max = bank[:max]
	banka.name = bank[:name]
	banka.save
end