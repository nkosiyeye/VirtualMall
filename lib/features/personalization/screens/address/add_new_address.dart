import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/appbar/appbar.dart';
import 'package:flutter_store/features/personalization/controllers/address_controller.dart';
import 'package:flutter_store/utils/constants/sizes.dart';
import 'package:flutter_store/utils/validators/validators.dart';
import 'package:iconsax/iconsax.dart';


class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key, required this.street, required this.city,
    required this.state, required this.country, required this.postalCode, required this.lat, required this.long});

  final String street;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final double lat;
  final double long;


  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    // Assign initial values to the controllers
    controller.street.text = street ?? '';
    controller.city.text = city ?? '';
    controller.state.text = state ?? '';
    controller.country.text = country ?? '';
    controller.postalCode.text = postalCode ?? '';
    controller.lat.text = lat.toString() ?? '';
    controller.long.text = long.toString() ?? '';

    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Add new Address'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Form(
          key: controller.addressFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.name,
                validator: (value) => TValidator.validateEmptyText('Name', value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.user),
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                controller: controller.phoneNumber,
                validator: TValidator.validatePhoneNumber,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.mobile),
                  labelText: 'Phone Number',
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.street,
                      validator: (value) =>
                          TValidator.validateEmptyText('Street', value),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.building_31),
                        labelText: 'Street',
                      ),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                      controller: controller.postalCode,
                      validator: (value) =>
                          TValidator.validateEmptyText('PostalCode', value),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.code),
                        labelText: 'Postal Code',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.city,
                      validator: (value) =>
                          TValidator.validateEmptyText('City', value),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.building),
                        labelText: 'City',
                      ),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                      controller: controller.state,
                      validator: (value) =>
                          TValidator.validateEmptyText('State', value),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.activity),
                        labelText: 'State',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                controller: controller.country,
                validator: (value) =>
                    TValidator.validateEmptyText('Country', value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.global),
                  labelText: 'Country',
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.lat,
                      validator: (value) =>
                          TValidator.validateEmptyText('Latitude', value),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.building),
                        labelText: 'Latitude',
                      ),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                      controller: controller.long,
                      validator: (value) =>
                          TValidator.validateEmptyText('Longitude', value),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.activity),
                        labelText: 'Longitude',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.defaultSpace),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.addNewAddresses(),
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
