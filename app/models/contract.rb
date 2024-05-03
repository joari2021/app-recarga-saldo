class Contract < ApplicationRecord
  belongs_to :client
  belongs_to :vehicle
  belongs_to :insurance_plan

  enum usage: [:ambulance, :cargo, :commercial, :competition, :sport, :special, :hardware_store, :crane, :heavy_machinery, :official, :private_transport, :fishing, :pleasure, :recreation, :recreation_pleasure, :taxi, :food_transport, :livestock_transport, :private_transport, :public_transport]
  enum ramo: [:vehicle, :vessel]

  enum coverage1: [:basic, :medium, :premium]
  enum coverage2: [:basic, :medium, :premium]
  enum coverage3: [:basic, :medium, :premium]
end
