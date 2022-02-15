# pdf4oereb

## Fragen
- Umgang mit Mehrsprachigkeit / Multilingualelementen? In V1_0 gehe ich anscheinend davon aus, dass nur ein Element vorhanden ist und verwende es "sprach-agnostisch" und ohne Berücksichtigung der gewählten Sprache (welche den statischen Teil regelt). Soll das weiterhin so gemacht werden oder versucht werden die gewünschte Sprache zu suchen (mit Fallback)? Dito für Images.
  * `select="data:PLRCadastreAuthority/data:OfficeAtWeb/data:LocalisedText[data:Language = 'fr']/data:Text` Wobei `fr` bereits als Parameter vorhanden wäre.
  * `select="data:PLRCadastreAuthority/data:OfficeAtWeb/data:LocalisedText[1]/data:Text"`
- Haftungsausschuss: Momentan ist es so, dass der erste `<Disclaimer>` in der ersten Spalte landet und der zweite in der zweiten Spalte. Das sprachunabhängig nach Weisung zu machen, ist hakelig. Zudem: Wie ist der Umgang mit weitere Disclaimern?


## Tests
- Affintransformation
- Geometryparser