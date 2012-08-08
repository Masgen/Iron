# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create!([{title: "adventure", screen_name: "Macera"},
                {title: "animation", screen_name: "Animasyon"},
                {title: "comedy", screen_name: "Komedi"},
                {title: "documentary", screen_name: "Belgesel"},
                {title: "drama", screen_name: "Dram"},
                {title: "erotic", screen_name: "Erotik"},
                {title: "science_fiction", screen_name: "Bilim Kurgu"},
                {title: "horror", screen_name: "Korku"},
                {title: "romance", screen_name: "Romantik"},
                {title: "thriller", screen_name: "Gerilim"},
                {title: "turk", screen_name: "Türk Filmi"},
                {title: "serie", screen_name: "Dizi"}])
