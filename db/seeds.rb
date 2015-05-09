# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


club_list = [
  [ "Cap", "cap@princeton.edu", "capcap", "rp_15u7lGBHXitMUPPCT4fZovAt" ],
  [ "Cannon", "cannon@princeton.edu", "cannon", "rp_15u7AhBHXitMUPPCDfMZTkA2" ],
  [ "Charter", "charter@princeton.edu", "charter", "rp_15wghpBHXitMUPPCCvqSwthu" ],
  [ "Cloister", "cloister@princeton.edu", "cloister", "rp_15wghPBHXitMUPPCc8qxKPrs" ],
  [ "Colonial", "colonial@princeton.edu", "colonial", "rp_15wggJBHXitMUPPC3htNeh8X" ],
  [ "Cottage", "cottage@princeton.edu", "cottage", "rp_15wgbvBHXitMUPPCsJ9YZ3Xb" ],
  [ "Ivy", "ivy@princeton.edu", "ivyivy", "rp_15u7kyBHXitMUPPC2142TksH" ],
  [ "Quad", "quad@princeton.edu", "quadquad", "rp_15u7lVBHXitMUPPCz4IfytU9" ],
  [ "Terrace", "terrace@princeton.edu", "terrace", "rp_15wgfZBHXitMUPPCI73wwAjQ" ],
  [ "TI", "ti@princeton.edu", "tititi", "rp_15wgfoBHXitMUPPCT3z9hFgl" ],
  [ "Tower", "tower@princeton.edu", "tower", "rp_15wggRBHXitMUPPCK401Szh3" ]
]

club_list.each do |club|
  Club.create( :name => club[0], :email => club[1], :password => club[2], :recipient_id => club[3] )
end