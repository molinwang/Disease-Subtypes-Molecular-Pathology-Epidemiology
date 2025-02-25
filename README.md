# AIPW_Subtype_MultipleMarker

The R package implements an augmented inverse probability weighting method for the missing subtype (or competing risks) problems where the subtypes are defined by multiple markers and typically different sets of cases have missing values for different markers; that is, some cases with unavailable subtype data may have partial information about the subtypes due to missing data in some (but not all) of the markers. The statistical method, described in the paper below, uses all the data available including the cases with only partial biomarker data available, and enjoys the double robustness property.

Lee J, Ogino S, Wang M. Weighting estimation in the cause-specific Cox regression with partially missing causes of failure. Stat Med. 2024 Jun 15;43(13):2575-2591. doi: 10.1002/sim.10084. Epub 2024 Apr 24. PMID: 38659326.

