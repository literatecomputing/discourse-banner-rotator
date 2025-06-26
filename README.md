# discourse-banner-rotator

**Add rotating set of banners to any plugin outlet**

Theme setting banner-text allows multiple html-safe items to be included. Each banner is displayed
at plugin outlet specified in setting `banner_outlet` (default is `above-main-container`, but any outlet
can be entered in the setting).

banner_delay sets the number of milliseconds between banner changes.

If any groups are entered into the `banner_exempt_groups` setting, members of those groups will
not see the banner (and `banner_include_groups` will be ignored). If `banner_include_groups` is
non-empty then the banner will display only if the user is a member of one or more of those groups.
If both are empty then all users see the banners.

Thanks to the [Grey Arrows Drone Club](https://greyarro.ws/) for funding development of this theme component.
