# Makefile to create a .zip archive of the repository

# Name of the zip file
FILENAME := repository.zip

# Default target
zip: $(FILENAME)

# Create the .zip archive
$(FILENAME):
	@echo "Creating $(FILENAME)..."
	@zip -r $(FILENAME) . -x@exclude.lst
	@echo "$(FILENAME) created."

# Clean target to remove the .zip file
clean:
	@echo "Cleaning up..."
	@rm -f $(FILENAME)
	@echo "Cleaned."

.PHONY: zip
