class Car < ActiveRecord::Base
   has_many :parkings

   #validates :license_plate, format: { with: /^[A-ZÑ]{3}\d{3}$/,
   #                                    message: "Ha ingresado una patente no valida en la Argentina" }

   validates :license_plate, format: { with: /\A[A-ZÑ]{3}\d{3}\z/,
                                       message: "Ha ingresado una patente no valida en la Argentina" }

end
