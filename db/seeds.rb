user = User.create(
  name: "Chris D'Ambrosio",
  email: "chris_dambrosio@playstation.sony.com"
)

contact_method1 = ContactMethod.create(
  label: "mobile",
  address: "6193374925",
  type_id: 0,
  user: user
)

NotificationRule.create(
  contact_method: contact_method1,
  start_delay: 0
)
