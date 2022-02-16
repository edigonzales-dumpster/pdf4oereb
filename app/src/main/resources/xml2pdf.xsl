<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  version="3.0" exclude-result-prefixes="geometry extract data" xmlns:oereb="http://oereb.geo.so.ch" xmlns:geometry="http://www.interlis.ch/geometry/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:fox="http://xmlgraphics.apache.org/fop/extensions" xmlns:extract="http://schemas.geo.admin.ch/V_D/OeREB/2.0/Extract" xmlns:data="http://schemas.geo.admin.ch/V_D/OeREB/2.0/ExtractData" xmlns:array="http://www.w3.org/2005/xpath-functions/array">
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="localeUrl" select="'Resources.de.resx'"/>
  <xsl:variable name="localeXml" select="document($localeUrl)/*"/>
  <xsl:variable name="OverlayImage">
    <xsl:value-of select="oereb:createOverlayImage(extract:GetExtractByIdResponse/data:Extract/data:RealEstate/data:Limit, extract:GetExtractByIdResponse/data:Extract/data:RealEstate/data:PlanForLandRegisterMainPage)"/>
  </xsl:variable>
  <xsl:decimal-format name="swiss" decimal-separator="." grouping-separator="'"/>
  <xsl:template match="extract:GetExtractByIdResponse/data:Extract">
    <fo:root language="de" font-family="Cadastra" font-weight="400" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:fox="http://xmlgraphics.apache.org/fop/extensions" xmlns:xsd="https://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xml:lang="en">
      <fo:layout-master-set>
        <fo:simple-page-master master-name="mainPage" page-height="297mm" page-width="210mm" margin-top="10mm" margin-bottom="12mm" margin-left="18mm" margin-right="18mm">
          <fo:region-body margin-top="30mm" margin-bottom="5mm" background-color="transparent"/>
          <fo:region-before extent="19mm" background-color="transparent"/>
          <fo:region-after extent="3mm" background-color="transparent"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      <fo:page-sequence master-reference="mainPage" id="page-sequence-id">
        <xsl:call-template name="insertHeaderAndFooter"/>
        <fo:flow flow-name="xsl-region-body">
          <fo:block-container height="28mm" background-color="transparent">
            <fo:block line-height="21pt" linefeed-treatment="preserve" font-weight="700" font-size="18pt">
              <xsl:value-of select="$localeXml/data[@name='MainPage.Title']/value/text()"/>
            </fo:block>
          </fo:block-container>
          <fo:block-container height="109mm" background-color="transparent">
            <fo:block font-size="0pt" padding="0mm" margin="0mm" line-height="0mm">
              <fo:external-graphic border="0.4pt solid black" width="173.7mm" height="99mm" scaling="non-uniform" content-width="scale-to-fit" content-height="scale-to-fit" fox:alt-text="PlanForLandRegisterMainPageImage">
                <xsl:if test="data:RealEstate/data:PlanForLandRegisterMainPage/data:Image[1]/data:Image">
                  <xsl:attribute name="src">
                    <xsl:text>url('data:</xsl:text>
                    <xsl:text>image/png;base64,</xsl:text>
                    <xsl:value-of select="oereb:createPlanForLandRegisterMainPageImage(data:RealEstate/data:PlanForLandRegisterMainPage, $OverlayImage)"/>
                    <xsl:text>')</xsl:text>
                  </xsl:attribute>
                </xsl:if>
              </fo:external-graphic>
            </fo:block>
          </fo:block-container>
          <fo:block-container font-size="8pt" background-color="transparent">
            <fo:table table-layout="fixed" width="100%">
              <fo:table-column column-width="68mm"/>
              <fo:table-column column-width="106mm"/>
              <fo:table-body>
                <fo:table-row border-bottom="0.4pt solid black" vertical-align="middle" line-height="6mm">
                  <fo:table-cell>
                    <fo:block font-weight="700">
                      <xsl:value-of select="$localeXml/data[@name='MainPage.RealEstate_DPR.Number']/value/text()"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block font-weight="700">
                      <xsl:value-of select="data:RealEstate/data:Number"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row border-bottom="0.4pt solid black" vertical-align="middle" line-height="6mm">
                  <fo:table-cell>
                    <fo:block>
                      <xsl:value-of select="$localeXml/data[@name='MainPage.RealEstate_DPR.Type']/value/text()"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block>
                      <xsl:value-of select="data:RealEstate/data:Type/data:Text/data:LocalisedText[1]/data:Text"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>

                <fo:table-row border-bottom="0.4pt solid black" vertical-align="middle" line-height="6mm">
                  <fo:table-cell>
                    <fo:block>E-GRID</fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block>
                      <xsl:value-of select="data:RealEstate/data:EGRID"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row border-bottom="0.4pt solid black" vertical-align="middle" line-height="6mm">
                  <fo:table-cell>
                    <fo:block>
                      <xsl:value-of select="$localeXml/data[@name='MainPage.Municipality_FosNr']/value/text()"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block><xsl:value-of select="data:RealEstate/data:MunicipalityName"/> (<xsl:value-of select="data:RealEstate/data:MunicipalityCode"/>)</fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <xsl:if test="data:RealEstate/data:SubunitOfLandRegister">
                  <fo:table-row border-bottom="0.4pt solid black" vertical-align="middle" line-height="6mm">
                    <fo:table-cell>
                      <fo:block>
                        <xsl:value-of select="data:RealEstate/data:SubunitOfLandRegisterDesignation"/>
                      </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                      <fo:block>
                        <xsl:value-of select="data:RealEstate/data:SubunitOfLandRegister"/>
                      </fo:block>
                    </fo:table-cell>
                  </fo:table-row>
                </xsl:if>
                <fo:table-row border-bottom="0.4pt solid black" vertical-align="middle" line-height="6mm">
                  <fo:table-cell>
                    <fo:block>
                      <xsl:value-of select="$localeXml/data[@name='MainPage.LandRegistryArea']/value/text()"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block line-height-shift-adjustment="disregard-shifts"><xsl:value-of select="format-number(data:RealEstate/data:LandRegistryArea, &quot;#'###&quot;, &quot;swiss&quot;)"/> m<fo:inline baseline-shift="super" font-size="60%">2</fo:inline></fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row border-bottom="0.4pt solid black" vertical-align="middle" line-height="6mm">
                  <fo:table-cell>
                    <fo:block>
                      <xsl:value-of select="$localeXml/data[@name='MainPage.UpdateDateCS']/value/text()"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block line-height-shift-adjustment="disregard-shifts"><xsl:value-of select="format-dateTime(/extract:GetExtractByIdResponse/data:Extract/data:CreationDate,'[D01].[M01].[Y0001]')"/></fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
          </fo:block-container>
          <fo:block-container margin-top="10mm" font-size="8pt" background-color="transparent">
            <fo:table table-layout="fixed" width="100%">
              <fo:table-column column-width="68mm"/>
              <fo:table-column column-width="106mm"/>
              <fo:table-body>
                <fo:table-row border-bottom="0.4pt solid black" vertical-align="middle" line-height="6mm">
                  <fo:table-cell>
                    <fo:block font-weight="700">
                      <xsl:value-of select="$localeXml/data[@name='MainPage.ExtractIdentifier']/value/text()"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block font-weight="700">
                      <xsl:value-of select="data:ExtractIdentifier"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row border-bottom="0.4pt solid black" vertical-align="middle" line-height="6mm">
                  <fo:table-cell>
                    <fo:block>
                      <xsl:value-of select="$localeXml/data[@name='MainPage.CreationDate']/value/text()"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block>
                      <xsl:value-of select="format-dateTime(data:CreationDate,'[D01].[M01].[Y0001]')"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row border-bottom="0.4pt solid black" vertical-align="middle" line-height="11pt" height="6mm">
                  <!-- Text darf vertikal nicht zentriert werden (wie bei den einzeiligen Zellen).  
                  Rechnerisch komme ich zwar auf 4.5pt (6mm Zeileinhöhe = 17pt minus 8pt für die Schrift), 
                  3.5pt passt aber besser zu den einzeiligen Zellen. Wahrscheinlich ist kann man 8pt 
                  nicht einfach so in die Rechnung einfliessen lassen.-->
                  <fo:table-cell padding-top="3.5pt">
                    <fo:block>
                      <xsl:value-of select="$localeXml/data[@name='MainPage.ResponsibleOffice']/value/text()"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell padding-top="3.5pt" padding-bottom="3.5pt">
                    <fo:block linefeed-treatment="preserve">
                      <xsl:value-of select="data:PLRCadastreAuthority/data:Name/data:LocalisedText[1]/data:Text"/>
                      <xsl:text>&#x000A;</xsl:text>
                      <xsl:value-of select="data:PLRCadastreAuthority/data:Street"/>
                      <xsl:text> </xsl:text>
                      <xsl:value-of select="data:PLRCadastreAuthority/data:Number"/>
                      <xsl:text>&#x000A;</xsl:text>
                      <xsl:value-of select="data:PLRCadastreAuthority/data:PostalCode"/>
                      <xsl:text> </xsl:text>
                      <xsl:value-of select="data:PLRCadastreAuthority/data:City"/>
                      <xsl:text>&#x000A;</xsl:text>
                      <fo:inline>
                        <fo:basic-link text-decoration="none" color="rgb(76,143,186)">
                          <xsl:attribute name="external-destination">
                            <xsl:value-of select="oereb:decodeURL(data:PLRCadastreAuthority/data:OfficeAtWeb/data:LocalisedText[1]/data:Text)"/>
                          </xsl:attribute>
                          <!--<xsl:value-of select="data:PLRCadastreAuthority/data:OfficeAtWeb/data:LocalisedText[data:Language = 'fr']/data:Text"/>-->
                            <xsl:value-of select="oereb:decodeURL(data:PLRCadastreAuthority/data:OfficeAtWeb/data:LocalisedText[1]/data:Text)"/>
                        </fo:basic-link>
                      </fo:inline>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
          </fo:block-container>
          <fo:block-container height="13mm" background-color="transparent">
            <fo:block page-break-before="always" line-height="18pt" linefeed-treatment="preserve" font-weight="700" font-size="15pt">
              <xsl:value-of select="$localeXml/data[@name='ContentPage.Title']/value/text()"/>
            </fo:block>
          </fo:block-container>
          <fo:block-container background-color="transparent">
            <fo:block line-height="11pt" linefeed-treatment="preserve" font-weight="700" font-size="8pt">
              <xsl:value-of select="$localeXml/data[@name='ContentPage.ConcernedTheme_Part1']/value/text()"/>
              <xsl:text> </xsl:text>
              <xsl:value-of select="data:RealEstate/data:Number"/>
              <xsl:text> </xsl:text>
              <xsl:value-of select="$localeXml/data[@name='ContentPage.ConcernedTheme_Part2']/value/text()"/>
              <xsl:text> </xsl:text>
              <xsl:value-of select="data:RealEstate/data:MunicipalityName"/>
              <xsl:if test="data:RealEstate/data:SubunitOfLandRegister">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="data:RealEstate/data:SubunitOfLandRegister"/>
              </xsl:if>
              <xsl:text> </xsl:text>
              <xsl:value-of select="$localeXml/data[@name='ContentPage.ConcernedTheme_Part3']/value/text()"/>
            </fo:block>
          </fo:block-container>
          <fo:block-container>
            <fo:block font-size="0pt" padding="0mm" margin="0mm" line-height="0mm">
              <fo:leader leader-pattern="rule" leader-length="100%" rule-style="solid" rule-thickness="0.4pt"/>
            </fo:block>
          </fo:block-container>
          <!-- Inhaltsverzeichnis -->
          <!--<xsl:apply-templates select="data:RealEstate" mode="toc"/>-->
          <!--Dummy Start (wieder löschen)-->
          <fo:block margin-top="10mm"></fo:block>
          <!--Dummy Ende-->
          <fo:block-container background-color="transparent">
            <fo:block line-height="11pt" linefeed-treatment="preserve" font-weight="700" font-size="8pt">
              <xsl:value-of select="$localeXml/data[@name='ContentPage.NotConcernedTheme']/value/text()"/>
            </fo:block>
          </fo:block-container>
          <fo:block-container>
            <fo:block font-size="0pt" padding="0mm" margin="0mm" line-height="0mm">
              <fo:leader leader-pattern="rule" leader-length="100%" rule-style="solid" rule-thickness="0.4pt"/>
            </fo:block>
          </fo:block-container>
          <fo:block-container margin-bottom="10mm" font-size="8pt" line-height="11pt" background-color="transparent">
            <fo:table table-layout="fixed" width="100%">
              <fo:table-body>
                <xsl:choose>
                  <xsl:when test="data:NotConcernedTheme">
                    <xsl:for-each select="data:NotConcernedTheme">
                      <fo:table-row vertical-align="middle">
                        <fo:table-cell>
                          <fo:block>
                            <xsl:value-of select="data:Text/data:LocalisedText[1]/data:Text"/>
                          </fo:block>
                        </fo:table-cell>
                      </fo:table-row>
                    </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>
                    <fo:table-row vertical-align="middle">
                      <fo:table-cell>
                        <fo:block>&#x2013;</fo:block>
                      </fo:table-cell>
                    </fo:table-row>
                  </xsl:otherwise>
                </xsl:choose>
              </fo:table-body>
            </fo:table>
          </fo:block-container>
          <fo:block-container background-color="transparent">
            <fo:block line-height="11pt" linefeed-treatment="preserve" font-weight="700" font-size="8pt">
              <xsl:value-of select="$localeXml/data[@name='ContentPage.ThemeWithoutData']/value/text()"/>
            </fo:block>
          </fo:block-container>
          <fo:block-container>
            <fo:block font-size="0pt" padding="0mm" margin="0mm" line-height="0mm">
              <fo:leader leader-pattern="rule" leader-length="100%" rule-style="solid" rule-thickness="0.4pt"/>
            </fo:block>
          </fo:block-container>
          <!-- margin-bottom ist heuristisch -->
          <fo:block-container margin-bottom="10mm" font-weight="400" font-size="8.5pt" line-height="11.5pt" font-family="Cadastra" background-color="transparent">
            <fo:table table-layout="fixed" width="100%">
              <fo:table-body>
                <xsl:choose>
                  <xsl:when test="data:ThemeWithoutData">
                    <xsl:for-each select="data:ThemeWithoutData">
                      <fo:table-row vertical-align="middle">
                        <fo:table-cell>
                          <fo:block>
                            <xsl:value-of select="data:Text/data:LocalisedText[1]/data:Text"/>
                          </fo:block>
                        </fo:table-cell>
                      </fo:table-row>
                    </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>
                    <fo:table-row vertical-align="middle">
                      <fo:table-cell>
                        <fo:block>&#x2013;</fo:block>
                      </fo:table-cell>
                    </fo:table-row>
                  </xsl:otherwise>
                </xsl:choose>
              </fo:table-body>
            </fo:table>
          </fo:block-container>
          <fo:block-container>
            <fo:block>
              <fo:footnote>
                <fo:inline/>
                <fo:footnote-body>
                  <fo:block keep-together.within-column="always">
                    <fo:block-container margin-top="0mm" margin-bottom="0mm" font-size="6pt" line-height="8pt" background-color="transparent">
                      <fo:table table-layout="fixed" width="100%" background-color="transparent">
                        <fo:table-column column-width="87mm"/>
                        <fo:table-column column-width="87mm"/>
                        <fo:table-body>
                          <fo:table-row vertical-align="top">
                            <fo:table-cell padding-right="1.5mm">
                              <fo:block font-weight="700">
                                <xsl:value-of select="$localeXml/data[@name='ContentPage.GeneralInformation']/value/text()"/>
                              </fo:block>
                              <fo:block>
                                <xsl:call-template name="textRenderer">
                                  <xsl:with-param name="textContent" select="data:GeneralInformation/data:LocalisedText[1]/data:Text" />
                                </xsl:call-template>
                              </fo:block>
                              <fo:block margin-top="2.2mm" font-weight="700">
                                <xsl:value-of select="data:Disclaimer[1]/data:Title/data:LocalisedText[1]/data:Text"/>
                              </fo:block>
                              <fo:block>
                                <xsl:call-template name="textRenderer">
                                  <xsl:with-param name="textContent" select="data:Disclaimer[1]/data:Content/data:LocalisedText[1]/data:Text" />
                                </xsl:call-template>
                              </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding-left="1.5mm">
                              <fo:block font-weight="700">
                                <xsl:value-of select="data:Disclaimer[2]/data:Title/data:LocalisedText[1]/data:Text"/>
                              </fo:block>
                              <fo:block>
                                <xsl:call-template name="textRenderer">
                                  <xsl:with-param name="textContent" select="data:Disclaimer[2]/data:Content/data:LocalisedText[1]/data:Text" />
                                </xsl:call-template>
                              </fo:block>
                              <fo:block margin-top="2.2mm">
                                <xsl:if test="data:QRCode">
                                  <fo:table table-layout="fixed" width="100%">
                                    <fo:table-column column-width="35mm"/>
                                    <fo:table-column column-width="40mm"/>
                                    <fo:table-body>
                                      <fo:table-row vertical-align="top">
                                        <fo:table-cell>
                                          <fo:block font-weight="700">
                                            <xsl:value-of select="$localeXml/data[@name='ContentPage.QRCode']/value/text()"/>
                                          </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding-left="4mm">
                                          <fo:block>
                                            <fo:external-graphic width="20mm" height="20mm" content-width="scale-to-fit" content-height="scale-to-fit" fox:alt-text="QRCode">
                                              <xsl:attribute name="src">
                                                <xsl:text>url('data:</xsl:text>
                                                <xsl:text>image/png;base64,</xsl:text>
                                                <xsl:value-of select="data:QRCode"/>
                                                <xsl:text>')</xsl:text>
                                              </xsl:attribute>
                                            </fo:external-graphic>
                                          </fo:block>
                                        </fo:table-cell>
                                      </fo:table-row>
                                    </fo:table-body>
                                  </fo:table>
                                </xsl:if>
                              </fo:block>
                            </fo:table-cell>
                          </fo:table-row>
                        </fo:table-body>
                      </fo:table>
                      <fo:block/>
                    </fo:block-container>
                  </fo:block>
                </fo:footnote-body>
              </fo:footnote>
            </fo:block>
          </fo:block-container>
        </fo:flow>
      </fo:page-sequence>
      <xsl:apply-templates select="data:RealEstate" mode="sheet"/>
      <xsl:call-template name="insertGlossary"/>
    </fo:root>
  </xsl:template>
  <xsl:template match="data:RealEstate" mode="sheet">
    <xsl:if test="(../data:ConcernedTheme)">
      <fo:page-sequence master-reference="mainPage" id="page-sequence-id">
        <xsl:call-template name="insertHeaderAndFooter"/>
        <fo:flow flow-name="xsl-region-body">
          <fo:block>
            <!-- Rechtsgültige Eigentumsbeschränkungen (inKraft) müssen vor laufenden Änderungen erscheinen. -->
            <xsl:for-each-group select="data:RestrictionOnLandownership" group-by="data:Theme/data:Code">
            <!--
              <xsl:message><xsl:value-of select="data:Theme/data:Text/data:LocalisedText[1]/data:Text" /></xsl:message>
              <xsl:message><xsl:value-of select="data:Lawstatus/data:Code" /></xsl:message>
              <xsl:message>*******************</xsl:message>
            -->

              <xsl:for-each-group select="current-group()" group-by="data:Lawstatus/data:Code">
                <xsl:sort data-type="number" order="ascending" select="(number(data:Lawstatus/data:Code='inForce') * 1) + (number(data:Lawstatus/data:Code='changeWithPreEffect') * 2) + (number(data:Lawstatus/data:Code='changeWithoutPreEffect') * 3)"/>
                <xsl:message><xsl:value-of select="data:Theme/data:Text/data:LocalisedText[1]/data:Text" /></xsl:message>
                <xsl:message><xsl:value-of select="data:Lawstatus/data:Code" /></xsl:message>
                <xsl:message>+++++++++++++++++++</xsl:message>


                <xsl:if test="not(current-group()/data:Theme/data:SubCode)">
                <!--
                  <xsl:message>Message Message Message</xsl:message>
                  <xsl:message><xsl:value-of select="data:Theme/data:Text/data:LocalisedText[1]/data:Text"/></xsl:message>
                -->
                  <fo:block-container background-color="thistle">
                    <fo:block id="{generate-id()}" page-break-before="always" linefeed-treatment="preserve" font-weight="700" font-size="15pt" line-height="18pt">
                      <xsl:value-of select="data:Theme/data:Text/data:LocalisedText[1]/data:Text"/>
                    </fo:block>
                  </fo:block-container>
                  <fo:block-container>
                    <!-- 2mm sind circa. 3mm sind bereits vorhanden. Kann nicht (?) besser gesteuert werden.-->
                    <fo:block margin-top="2mm" font-size="8pt" line-height="11pt" font-weight="700" background-color="wheat">
                      <xsl:value-of select="data:Lawstatus/data:Text/data:LocalisedText[1]/data:Text"/>
                    </fo:block>
                  </fo:block-container>
                  <!--<xsl:call-template name="handleRestrictionOnLandownership"/>-->
                </xsl:if>



              </xsl:for-each-group>
            </xsl:for-each-group>
          </fo:block>
        </fo:flow>
      </fo:page-sequence>
    </xsl:if>
  </xsl:template>
  <xsl:template name="insertHeaderAndFooter">
    <fo:static-content flow-name="xsl-region-before">
      <fo:block>
        <fo:block-container absolute-position="absolute" top="0mm" left="0mm" background-color="transparent">
          <fo:block font-size="0pt" padding="0mm" margin="0mm" line-height="0mm">
            <fo:external-graphic width="44mm" content-width="scale-to-fit" fox:alt-text="FederalLogo">
              <xsl:if test="/extract:GetExtractByIdResponse/data:Extract/data:FederalLogo">
                <xsl:attribute name="src">
                  <xsl:text>url('data:</xsl:text>
                  <xsl:text>image/png;base64,</xsl:text>
                  <xsl:value-of select="oereb:fixImage(/extract:GetExtractByIdResponse/data:Extract/data:FederalLogo)"/>
                  <xsl:text>')</xsl:text>
                </xsl:attribute>
              </xsl:if>
          <!--
              <xsl:if test="/extract:GetExtractByIdResponse/data:Extract/data:FederalLogoRef and not(/extract:GetExtractByIdResponse/data:Extract/data:FederalLogo)">
                <xsl:attribute name="src">
                  <xsl:text>url('data:</xsl:text>
                  <xsl:text>image/png;base64,</xsl:text>
                  <xsl:value-of select="oereb:fixImage(/extract:GetExtractByIdResponse/data:Extract/data:FederalLogoRef)"/>
                  <xsl:text>')</xsl:text>
                </xsl:attribute>
              </xsl:if>
            -->
            </fo:external-graphic>
          </fo:block>
        </fo:block-container>
        <fo:block-container absolute-position="absolute" top="0mm" left="56mm" background-color="transparent">
          <fo:block font-size="0pt" padding="0mm" margin="0mm" line-height="0mm">
            <fo:external-graphic border="0pt solid black" width="30mm" height="13mm" scaling="uniform" content-width="scale-to-fit" content-height="scale-to-fit" text-align="center" fox:alt-text="CantonalLogo">
              <xsl:if test="/extract:GetExtractByIdResponse/data:Extract/data:CantonalLogo">
                <xsl:attribute name="src">
                  <xsl:text>url('data:</xsl:text>
                  <xsl:text>image/png;base64,</xsl:text>
                  <xsl:value-of select="oereb:fixImage(/extract:GetExtractByIdResponse/data:Extract/data:CantonalLogo)"/>
                  <xsl:text>')</xsl:text>
                </xsl:attribute>
              </xsl:if>
          <!--
              <xsl:if test="/extract:GetExtractByIdResponse/data:Extract/data:CantonalLogoRef and not(/extract:GetExtractByIdResponse/data:Extract/data:CantonalLogo)">
                <xsl:attribute name="src">
                  <xsl:text>url('data:</xsl:text>
                  <xsl:text>image/png;base64,</xsl:text>
                  <xsl:value-of select="oereb:fixImage(/extract:GetExtractByIdResponse/data:Extract/data:CantonalLogoRef)"/>
                  <xsl:text>')</xsl:text>
                </xsl:attribute>
              </xsl:if>
            -->
            </fo:external-graphic>
          </fo:block>
        </fo:block-container>
        <fo:block-container absolute-position="absolute" top="0mm" left="97mm" background-color="transparent">
          <fo:block font-size="0pt" padding="0mm" margin="0mm" line-height="0mm">
            <fo:external-graphic width="30mm" height="13mm" scaling="uniform" content-width="scale-to-fit" content-height="scale-to-fit" text-align="center" fox:alt-text="MunicipalityLogo">
              <xsl:if test="/extract:GetExtractByIdResponse/data:Extract/data:MunicipalityLogo">
                <xsl:attribute name="src">
                  <xsl:text>url('data:</xsl:text>
                  <xsl:text>image/png;base64,</xsl:text>
                  <xsl:value-of select="oereb:fixImage(/extract:GetExtractByIdResponse/data:Extract/data:MunicipalityLogo)"/>
                  <xsl:text>')</xsl:text>
                </xsl:attribute>
              </xsl:if>
          <!--
              <xsl:if test="/extract:GetExtractByIdResponse/data:Extract/data:MunicipalityLogoRef and not(/extract:GetExtractByIdResponse/data:Extract/data:MunicipalityLogo)">
                <xsl:attribute name="src">
                  <xsl:text>url('data:</xsl:text>
                  <xsl:text>image/png;base64,</xsl:text>
                  <xsl:value-of select="oereb:fixImage(/extract:GetExtractByIdResponse/data:Extract/data:MunicipalityLogoRef)"/>
                  <xsl:text>')</xsl:text>
                </xsl:attribute>
              </xsl:if>
            -->
            </fo:external-graphic>
          </fo:block>
        </fo:block-container>
        <fo:block-container absolute-position="absolute" top="0mm" left="139mm" background-color="transparent">
          <fo:block font-size="0pt" padding="0mm" margin="0mm" line-height="0mm">
            <fo:external-graphic width="35mm" height="10mm" scaling="non-uniform" content-width="scale-to-fit" content-height="scale-to-fit" fox:alt-text="LogoPLRCadastre">
              <xsl:if test="/extract:GetExtractByIdResponse/data:Extract/data:LogoPLRCadastre">
                <xsl:attribute name="src">
                  <xsl:text>url('data:</xsl:text>
                  <xsl:text>image/png;base64,</xsl:text>
                  <!--<xsl:value-of select="oereb:fixImage(/extract:GetExtractByIdResponse/data:Extract/data:LogoPLRCadastre)"/>-->
                  <xsl:value-of select="oereb:fixImage(/extract:GetExtractByIdResponse/data:Extract/data:LogoPLRCadastre)"/>
                  <xsl:text>')</xsl:text>
                </xsl:attribute>
              </xsl:if>
          <!--
              <xsl:if test="/extract:GetExtractByIdResponse/data:Extract/data:LogoPLRCadastreRef and not(/extract:GetExtractByIdResponse/data:Extract/data:LogoPLRCadastre)">
                <xsl:attribute name="src">
                  <xsl:text>url('data:</xsl:text>
                  <xsl:text>image/png;base64,</xsl:text>
                  <xsl:value-of select="oereb:fixImage(/extract:GetExtractByIdResponse/data:Extract/data:LogoPLRCadastreRef)"/>
                  <xsl:text>')</xsl:text>
                </xsl:attribute>
              </xsl:if>
          -->
            </fo:external-graphic>
          </fo:block>
        </fo:block-container>
        <fo:block-container absolute-position="absolute" top="19mm" left="0mm">
          <fo:block font-size="0pt" padding="0mm" margin="0mm" line-height="0mm">
            <fo:leader leader-pattern="rule" leader-length="100%" rule-style="solid" rule-thickness="0.4pt"/>
          </fo:block>
        </fo:block-container>
      </fo:block>
    </fo:static-content>
    <fo:static-content flow-name="xsl-region-after">
      <fo:block-container absolute-position="absolute" top="0mm" left="0mm">
        <fo:block font-size="0pt" padding="0mm" margin="0mm" line-height="0mm">
          <fo:leader leader-pattern="rule" leader-length="100%" rule-style="solid" rule-thickness="0.8pt"/>
        </fo:block>
        <fo:table table-layout="fixed" width="100%" margin-top="0.5mm" font-size="6pt">
          <fo:table-column column-width="50%"/>
          <fo:table-column column-width="50%"/>
          <fo:table-body>
            <fo:table-row vertical-align="bottom">
              <fo:table-cell vertical-align="bottom">
                <fo:block vertical-align="bottom">
                  <xsl:value-of select="format-dateTime(/extract:GetExtractByIdResponse/data:Extract/data:CreationDate,'[D01].[M01].[Y0001]')"/>
                  <fo:inline padding-left="1em">
                    <xsl:value-of select="format-dateTime(/extract:GetExtractByIdResponse/data:Extract/data:CreationDate,'[H01]:[m01]:[s01]')"/>
                  </fo:inline>
                  <fo:inline padding-left="1em">
                    <xsl:value-of select="/extract:GetExtractByIdResponse/data:Extract/data:ExtractIdentifier"/>
                  </fo:inline>
                </fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right">
                <!-- <fo:block>Seite <fo:page-number/>/<fo:page-number-citation-last ref-id="page-sequence-id"/></fo:block> -->
                <fo:block><xsl:value-of select="$localeXml/data[@name='Page']/value/text()"/><xsl:text> </xsl:text><fo:page-number/>/<fo:page-number-citation ref-id="last-page"/></fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </fo:block-container>
    </fo:static-content>
  </xsl:template>
  <xsl:template name="insertGlossary">
    <fo:page-sequence master-reference="mainPage" id="page-sequence-id">
      <xsl:call-template name="insertHeaderAndFooter"/>
      <fo:flow flow-name="xsl-region-body">
        <fo:block>
          <fo:block-container height="13mm" background-color="transparent">
            <fo:block page-break-before="always" line-height="18pt" linefeed-treatment="preserve" font-weight="700" font-size="15pt">
              <xsl:value-of select="$localeXml/data[@name='GlossaryPage.Title']/value/text()"/>
            </fo:block>
          </fo:block-container>
          <fo:block-container font-size="8pt" line-height="11pt" background-color="transparent">
            <fo:table table-layout="fixed" width="100%">
              <fo:table-column column-width="174mm"/>
              <fo:table-body>
                <xsl:for-each select="data:Glossary">
                  <xsl:sort select="data:Title/data:LocalisedText[1]/data:Text" lang="de-CH"/>
                  <fo:table-row border-bottom="0.4pt solid black" vertical-align="middle" line-height="11pt">
                    <fo:table-cell padding-top="1mm" padding-bottom="1mm">
                      <fo:block>
                        <fo:inline font-weight="700"><xsl:value-of select="data:Title/data:LocalisedText[1]/data:Text"/>: </fo:inline>
                        <xsl:value-of select="data:Content/data:LocalisedText[1]/data:Text"/>
                      </fo:block>
                    </fo:table-cell>
                  </fo:table-row>
                </xsl:for-each>
              </fo:table-body>
            </fo:table>
          </fo:block-container>
        </fo:block>
        <fo:block id="last-page"/>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <!-- Falls simple Werte zurückgeliefert werden, eher Funktion verwenden. Wenn neue Nodes 
  entstehen, dann eher named templates. -->
  <xsl:template name="textRenderer">
    <xsl:param name="textContent"/>
    <xsl:analyze-string select="$textContent" regex="(www|http://|https://)([\w.]*)?">
      <xsl:matching-substring>
        <fo:inline>
          <fo:basic-link text-decoration="none" color="rgb(76,143,186)">
            <xsl:attribute name="external-destination">
              <xsl:value-of select="."/>
            </xsl:attribute>
            <!--<xsl:value-of select="substring(regex-group(0),8)"/>-->
            <xsl:value-of select="regex-group(0)"/>
          </fo:basic-link>
        </fo:inline>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="."/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:template>

</xsl:stylesheet>
