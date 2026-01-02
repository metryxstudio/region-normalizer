# Region Normalizer

A server-side Google Tag Manager variable template that normalizes region/state names for server-side tracking by removing spaces and punctuation while preserving UTF-8 characters. Includes Croatian county mapping.

## Overview

This template prepares region/state names for hashing and sending to advertising platforms like Facebook CAPI, Google Ads, and TikTok. It handles various regional naming conventions including special support for Croatian counties (županije).

## Installation

1. In your server-side GTM container, go to **Templates** → **Variable Templates** → **Search Gallery**
2. Search for "Region Normalizer"
3. Click **Add to workspace**

## Configuration

| Field | Description |
|-------|-------------|
| **Raw Region/State** | Region, state, or county name in its original form |

## Examples

| Input | Output |
|-------|--------|
| `California` | `california` |
| `CA` | `ca` |
| `New York` | `newyork` |
| `Zagrebačka županija` | `zagrebačka` |
| `Splitsko-dalmatinska županija` | `splitsko-dalmatinska` |
| `Grad Zagreb` | `zagreb` |
| `Bayern` | `bayern` |
| `Île-de-France` | `îledefrance` |
| `Greater London` | `greaterlondon` |

## Features

- Converts to lowercase
- Removes spaces and punctuation
- Preserves UTF-8 characters (accents, diacritics)
- **Croatian county support:**
  - Automatically strips " županija" suffix
  - Maps "Grad Zagreb" to "zagreb"
  - Preserves hyphenated county names (e.g., `splitsko-dalmatinska`)
- Returns `undefined` for empty or invalid input

## Croatian Counties (Županije)

All 20 Croatian counties + City of Zagreb are supported:

| Full Name | Normalized Output |
|-----------|-------------------|
| Zagrebačka županija | `zagrebačka` |
| Splitsko-dalmatinska županija | `splitsko-dalmatinska` |
| Primorsko-goranska županija | `primorsko-goranska` |
| Osječko-baranjska županija | `osječko-baranjska` |
| Grad Zagreb | `zagreb` |
| ... and all others | |

## Usage Example

1. Create a variable using this template
2. Set **Raw Region/State** to your region data source (e.g., `{{Event Data - state}}`)
3. Use the normalized output in your tracking tags or hash it for CAPI

## Author

**Metryx Studio**  
Website: [metryx.studio](https://metryx.studio)  
Contact: filip@metryx.studio

## License

Apache License 2.0
