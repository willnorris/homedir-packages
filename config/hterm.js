// Run in the JavaScript console of the hterm browser window

// Modified from https://gist.github.com/russelldavies/5745528

// Clear all existing settings - you probably don't want to do this.
// Preferences are now stored in "chrome.storage.sync" instead of
// "window.localStorage" so if you clear your preferences the changes
// will be propagated to other devices.
//term_.prefs_.storage.clear();

var s7d_colors = {
  'base03':  '#002b36',
  'base02':  '#073642',
  'base01':  '#586e75',
  'base00':  '#657b83',
  'base0':   '#839496',
  'base1':   '#93a1a1',
  'base2':   '#eee8d5',
  'base3':   '#fdf6e3',
  'yellow':  '#b58900',
  'orange':  '#cb4b16',
  'red':     '#dc322f',
  'magenta': '#d33682',
  'violet':  '#6c71c4',
  'blue':    '#268bd2',
  'cyan':    '#2aa198',
  'green':   '#859900'
};

var htermProfiles = {
    'solarized-dark': {
        'background-color': s7d_colors.base03,
        'foreground-color': s7d_colors.base0,
        'cursor-color': lib.colors.setAlpha(lib.colors.hexToRGB(s7d_colors.red), 0.6),
        'color-palette-overrides': [s7d_colors.base02, s7d_colors.red,
          s7d_colors.green, s7d_colors.yellow, s7d_colors.blue, s7d_colors.magenta, s7d_colors.cyan,
          s7d_colors.base2, s7d_colors.base03, s7d_colors.orange, s7d_colors.base01, s7d_colors.base00,
          s7d_colors.base0, s7d_colors.violet, s7d_colors.base1, s7d_colors.base3],
    },
    'solarized-light': {
        'background-color': s7d_colors.base3,
        'foreground-color': s7d_colors.base00,
        'cursor-color': lib.colors.setAlpha(lib.colors.hexToRGB(s7d_colors.red), 0.6),
        'color-palette-overrides': [s7d_colors.base02, s7d_colors.red,
          s7d_colors.green, s7d_colors.yellow, s7d_colors.blue, s7d_colors.magenta, s7d_colors.cyan,
          s7d_colors.base2, s7d_colors.base03, s7d_colors.orange, s7d_colors.base01, s7d_colors.base00,
          s7d_colors.base0, s7d_colors.violet, s7d_colors.base1, s7d_colors.base3],
    },
    'my-dark': {
        'foreground-color': '#dcdfe4',
        'background-color': '#202229',
        'cursor-color': '#e06c75',
        'color-palette-overrides': [
            '#2c313a', // black
            '#e06c75', // red
            '#98c379', // green
            '#e5c07b', // yellow
            '#61afef', // blue
            '#c678dd', // magenta
            '#56b6c2', // cyan
            '#dcdfe4', // white
            '#5a6374', // bright black
            '#e06c75', // bright red
            '#98c379', // bright green
            '#e5c07b', // bright yellow
            '#61afef', // bright blue
            '#c678dd', // bright magenta
            '#56b6c2', // bright cyan
            '#dcdfe4', // bright white
        ],
    },
};

// set default profile
htermProfiles['default'] = htermProfiles['my-dark'];

var currentProfile = term_.profileId_;

for (name in htermProfiles) {
    prefs = htermProfiles[name];

    term_.setProfile(name);
    term_.prefs_.resetAll();

    for (var name in prefs) {
        term_.prefs_.set(name, prefs[name]);
    }

    term_.prefs_.set('font-size', 14);
    term_.prefs_.set('enable-bold', false);
    term_.prefs_.set('font-family', '"Source Code Pro", monospace');
    term_.prefs_.set('font-smoothing', 'subpixel-antialiased');
    term_.prefs_.set('user-css', 'http://fonts.googleapis.com/css?family=Source+Code+Pro|Anonymous+Pro');

    term_.prefs_.set('cursor-blink', true);
    term_.prefs_.set('cursor-blink-cycle', [800, 500]);
    term_.prefs_.set('scrollbar-visible', '');
    term_.prefs_.set('desktop-notification-bell', true);
    term_.prefs_.set('mouse-right-click-paste', false);
};

// restore current profile
term_.setProfile(currentProfile);

// From then on to set the profile at will: `term_.setProfile('profile_name)`,
// e.g.: `term_.setProfile('solarized-dark')`
