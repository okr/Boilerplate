class ContactForm < MailForm
	subject "Contact Us"
	recipients Settings.admin_email
	sender{|c| %{"#{c.name}" <#{c.email}>} }

	attribute :name,        :validate => true
	attribute :email,       :validate => /[^@]+@[^\.]+\.[\w\.\-]+/
	attribute :message,     :validate => true
end