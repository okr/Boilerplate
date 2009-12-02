class ContactForm < SimpleForm
	subject "Contact Unander Construction"
	recipients Settings.admin_email

	attribute :name,        :validate => true
	attribute :email,       :validate => /[^@]+@[^\.]+\.[\w\.\-]+/
	attribute :message,     :validate => true
end