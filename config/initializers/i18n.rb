#encoding: utf-8

# Uses the I18n module to set the default locale. I18n = internationalization, or i + 18 letters + n.
I18n.default_locale = :en

# Defines a list of associations between display names and locale names. Often the best way is to copy and paste from
# a website that displays it properly. By calling html_safe, we inform Rails that the string is safe to be interpreted
# as containing HTML.
LANGUAGES = [
    ['English',                   'en'],
    ["Espa&ntilde;ol".html_safe,  'es']
]