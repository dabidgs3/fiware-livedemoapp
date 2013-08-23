#!/bin/bash
# Copyright 2013 Telefonica Investigación y Desarrollo, S.A.U
#
# This file is part of FI-WARE LiveDemo App
#
# FI-WARE LiveDemo App is free software: you can redistribute it and/or modify it under the terms
# of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# FI-WARE LiveDemo App is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License
# for more details.
#
# You should have received a copy of the GNU Affero General Public License along with FI-WARE LiveDemo App. If not,
# see http://www.gnu.org/licenses/.
#
# For those usages not covered by the GNU Affero General Public License please contact with fermin at tid dot es

AMMS=$1
ATTR=$2
VALUE=$3
DATE=$(date --iso-8601=seconds)
(curl localhost:1026/NGSI10/updateContext -s -S --header 'Content-Type: application/xml' -d @- | xmllint --format - ) <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<updateContextRequest>
  <contextElementList>
        <contextElement>
          <entityId type="AMMS" isPattern="false">
            <id>OUTSMART.AMMS_$AMMS</id>
          </entityId>
          <contextAttributeList>
            <contextAttribute>
              <name>TimeInstant</name>
              <type>urn:x-ogc:def:trs:IDAS:1.0:ISO8601</type>
              <contextValue>$DATE</contextValue>
            </contextAttribute>
            <contextAttribute>
              <name>$ATTR</name>
              <contextValue>$VALUE</contextValue>
            </contextAttribute>
      </contextAttributeList>
    </contextElement>
  </contextElementList>
  <updateAction>Update</updateAction>
</updateContextRequest>
EOF
