# MetaSave

[Godot Plugin] Save\Load Metadata

---

### How it Works:

This plugin adds a single node for handling the saving and loading of its
parent's metadata. If the `Auto` variable is enabled (default) metadata will be loaded with `_ready` and saved with `_exit_tree`. Change the `Profile` variable for unique save profiles.

Save Method: `$MetaSave.save_meta()`

Load Method: `$MetaSave.load_meta()`
