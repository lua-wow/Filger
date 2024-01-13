FILENAME := actions-$(REF_NAME).zip
EXCLUDES := '.git/*' '.github/*' '.gitignore' '.gitattributes' '.gitmodules' Makefile 'docs/*'
EXCLUDES += $(addprefix libs/LibStub/, 'tests/*' '.git' '.gitignore' '.gitattributes' 'README.md')
EXCLUDES += $(addprefix libs/CallbackHandler-1.0/, '.git' '.gitignore' '.gitattributes' 'README.md')
EXCLUDES += $(addprefix libs/LibClassicDurations/, '.github/*' '.loader/*' '.git' '.gitignore' '.gitattributes' '.luacheckrc' '.pkgmeta' 'README.md')

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
