FILENAME := actions-$(REF_NAME).zip
EXCLUDES := '.git/*' '.github/*' '.gitignore' '.gitattributes' Makefile 'docs/*'

.PHONY: changelog
changelog:
	@git log -1 --pretty=%B | head -c -1

.PHONY: zip
zip:
	@echo "Creating $(TAG) zip file..."
	@zip -r $(FILENAME) * -x $(addprefix -x ,$(EXCLUDES))
	@echo "$(FILENAME) created successfully."

.PHONY: clean
clean:
	@echo "Cleaning up..."
	@rm -f $(FILENAME)
	@echo "Cleanup complete."
