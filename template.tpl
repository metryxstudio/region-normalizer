___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.

___INFO___

{
  "type": "MACRO",
  "id": "region_normalizer",
  "version": 1,
  "securityGroups": [],
  "displayName": "Region Normalizer",
  "description": "Normalizes region/state names for server-side tracking by removing spaces and punctuation while preserving UTF-8 characters. Includes Croatian county mapping.",
  "containerContexts": [
    "SERVER"
  ],
  "categories": ["UTILITY"],
  "brand": {
    "id": "metryxstudio",
    "displayName": "Metryx Studio"
  }
}

___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "rawRegion",
    "displayName": "Raw Region/State",
    "simpleValueType": true,
    "help": "Region, state, or county name in its original form (e.g., 'California', 'Zagrebačka županija', 'CA')."
  }
]

___SANDBOXED_JS_FOR_SERVER___

var makeString = require('makeString');

var normalizeRegion = function(data) {
  var rawRegion = data.rawRegion;

  if (!rawRegion) {
    return undefined;
  }

  var regionString = makeString(rawRegion).trim().toLowerCase();
  
  if (regionString.length === 0) {
    return undefined;
  }
  
  var croatianCounties = {
    'zagrebačka županija': 'zagrebačka',
    'krapinsko-zagorska županija': 'krapinsko-zagorska',
    'sisačko-moslavačka županija': 'sisačko-moslavačka',
    'karlovačka županija': 'karlovačka',
    'varaždinska županija': 'varaždinska',
    'koprivničko-križevačka županija': 'koprivničko-križevačka',
    'bjelovarsko-bilogorska županija': 'bjelovarsko-bilogorska',
    'primorsko-goranska županija': 'primorsko-goranska',
    'ličko-senjska županija': 'ličko-senjska',
    'virovitičko-podravska županija': 'virovitičko-podravska',
    'požeško-slavonska županija': 'požeško-slavonska',
    'brodsko-posavska županija': 'brodsko-posavska',
    'zadarska županija': 'zadarska',
    'osječko-baranjska županija': 'osječko-baranjska',
    'šibensko-kninska županija': 'šibensko-kninska',
    'vukovarsko-srijemska županija': 'vukovarsko-srijemska',
    'splitsko-dalmatinska županija': 'splitsko-dalmatinska',
    'istarska županija': 'istarska',
    'dubrovačko-neretvanska županija': 'dubrovačko-neretvanska',
    'međimurska županija': 'međimurska',
    'grad zagreb': 'zagreb'
  };
  
  if (croatianCounties[regionString]) {
    return croatianCounties[regionString];
  }
  
  var zupaIndex = regionString.indexOf(' županija');
  if (zupaIndex !== -1) {
    regionString = regionString.substring(0, zupaIndex);
  }
  
  var charsToRemove = ' \'"-.,;:!?()[]{}/@#$%^&*+=_|\\<>~`0123456789';
  var normalizedRegion = '';
  
  for (var i = 0; i < regionString.length; i++) {
    var char = regionString.charAt(i);
    
    if (charsToRemove.indexOf(char) === -1) {
      normalizedRegion = normalizedRegion + char;
    }
  }
  
  if (normalizedRegion.length === 0) {
    return undefined;
  }
  
  return normalizedRegion;
};

return normalizeRegion(data);


___SERVER_PERMISSIONS___

[]


___TESTS___

scenarios:
- name: Basic normalization
  code: |-
    const mockData = {
      rawRegion: 'California'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('california');
- name: US state code
  code: |-
    const mockData = {
      rawRegion: 'CA'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('ca');
- name: Region with space
  code: |-
    const mockData = {
      rawRegion: 'New York'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('newyork');
- name: Croatian county full name
  code: |-
    const mockData = {
      rawRegion: 'Zagrebačka županija'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('zagrebačka');
- name: Croatian county short name
  code: |-
    const mockData = {
      rawRegion: 'Zagrebačka'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('zagrebačka');
- name: Međimurska county
  code: |-
    const mockData = {
      rawRegion: 'Međimurska županija'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('međimurska');
- name: City of Zagreb
  code: |-
    const mockData = {
      rawRegion: 'Grad Zagreb'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('zagreb');
- name: Splitsko-dalmatinska county
  code: |-
    const mockData = {
      rawRegion: 'Splitsko-dalmatinska županija'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('splitsko-dalmatinska');
- name: German region
  code: |-
    const mockData = {
      rawRegion: 'Bayern'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('bayern');
- name: Empty input returns undefined
  code: |-
    const mockData = {
      rawRegion: ''
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(undefined);
- name: Only whitespace returns undefined
  code: |-
    const mockData = {
      rawRegion: '   '
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(undefined);
- name: Undefined input returns undefined
  code: |-
    const mockData = {};
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo(undefined);
- name: UK region
  code: |-
    const mockData = {
      rawRegion: 'Greater London'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('greaterlondon');
- name: French region with accents
  code: |-
    const mockData = {
      rawRegion: 'Île-de-France'
    };
    let variableResult = runCode(mockData);
    assertThat(variableResult).isEqualTo('îledefrance');
