//
//  Licensed to Jasig under one or more contributor license
//  agreements. See the NOTICE file distributed with this work
//  for additional information regarding copyright ownership.
//  Jasig licenses this file to you under the Apache License,
//  Version 2.0 (the "License"); you may not use this file
//  except in compliance with the License. You may obtain a
//  copy of the License at:
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on
//  an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied. See the License for the
// specific language governing permissions and limitations
// under the License.
//

/* Insert Bedework calendar events list from a json feed.

 NOTE: No jQuery or other library dependencies should be used in this file
 because it is used both by the public Bedework web client and
 by javascript widgets embedded on other sites. It should stand alone.

 */

/*
 global bwObject
 */
function insertBwEvents(outputContainerID,bwObject,options) {
  const outputContainer = document.getElementById(outputContainerID);
  let output = "";
  const eventlist = [];
  let eventIndex = 0;
  let bwListOptions;

  const defaults = {
    calendarServer: '',
    calSuiteContext: '/cal',
    displayContactInDetails: true,
    displayCostInDetails: true,
    displayDayNameInList: false, // display Monday, Tuesday, Wednesday, etc.
    displayDayNameTruncated: true, // shorten day names to three characters 'Mon','Tue','Wed' etc
    displayDescription: false,
    displayEndDateInList: true,
    displayEventDetailsInline: false,
    displayImageInList: false,
    displayLocationInList: false,
    displayNoEventText: true,
    displayTagsInDetails: true,
    displayTimeInList: true,
    displayTimezoneInDetails: true,
    displayTopicalAreasInList: false,
    displayThumbnailInList: false,
    eventImagePrefix: '/pubcaldav',
    limit: 5,
    limitList: false,
    listMode: 'byTitle', // values: 'byDate' or 'byTitle' - highlights the date or title first (sort is always by date)
    locationTitle: 'Location:',
    noEventsText: 'No events to display',
    showCount: true,
    showTitle: true,
    showTitleWhenNoEvents: true,
    suppressEndDateInList: false,
    suppressStartDateInList: false,
    thumbWidth: 80,
    title: 'Upcoming Events',
    topicalAreasTitle: 'Topical Areas:',
    untilText: 'Ends',
    useContentDiv: false,
    useFullImageThumbs: true,
    useImageDiv: false,
    usePlaceholderThumb: false,
  };

  // merge in user-defined options
  if (typeof options == "object") {
    for (const key in options) {
      if(options.hasOwnProperty(key))
        defaults[key] = options[key];
    }
  }

  bwListOptions = defaults;

  // Check first to see if whe have events:
  /*
   * @property {object} bwObject
   * @property {object} bwObject.bwEventList
   */
  if ((bwObject === undefined) ||
      (bwObject.bwEventList === undefined) ||
      (bwObject.bwEventList.events === undefined) ||
      (bwObject.bwEventList.events.length === 0)) {

    if (bwListOptions.showTitleWhenNoEvents) {
      output += "<h3 class=\"bwEventsTitle\">" + bwListOptions.title + "</h3>";
    }
    if (bwListOptions.displayNoEventText) {
      output += "<ul class=\"bwEventList\"><li>" + bwListOptions.noEventsText + "</li></ul>";
    }
  } else {
    let i;
    // get events
    /**
     * @param {object} bwEventList.events[]
     * @param {string} bwEventList.resultSize
     */
    const bwEventList = bwObject.bwEventList;

    for (i = 0; i < bwEventList.events.length; i++) {
      eventlist[eventIndex] = i;
      eventIndex++;
    }

    // GENERATE OUTPUT
    // This is where you may wish to customize the output.  To see what
    // fields are available for events, look at the json source file included
    // by the widget code.  The core formatting is done in formatDateTime()
    // and formatSummary()

    // The title is included because you may wish to hide it when
    // no events are present.
    if (bwListOptions.showTitle) {
      output += "<h3 class=\"bwEventsTitle\">";
      if (bwListOptions.showCaret) {
        output += "<span class=\"caret caret-right\"> </span>";
      }
      output += bwListOptions.title;
      if (bwListOptions.showCount) {
        output += " <span class=\"bwEventsCount\">("
            + bwEventList.resultSize + ")</span>";
      }
      output += "</h3>";
    }

    // Output the list
    output += "<ul class=\"bwEventList\">";

    // Now, iterate over the events:
    for (i in eventlist) {
      // stop if we've reached a limit on the number of events
      if (bwListOptions.limitList && (bwListOptions.limit === i)) {
        break;
      }

      // provide a shorthand reference to the event:
      const event = bwEventList.events[eventlist[i]];

      // create the list item:
      if (event.status === "CANCELLED") {
        output += '<li class="bwStatusCancelled">';
      } else if (event.status === "TENTATIVE") {
        output += '<li class="bwStatusTentative">';
      } else {
        output += "<li>";
      }

      if (bwListOptions.useImageDiv) {
        output += "<div class=\"bwEventImage\">";
      }

      // event thumbnail
      if (bwListOptions.displayThumbnailInList) {
        output += formatBwThumbnail(event, bwListOptions);
      }

      if (bwListOptions.displayImageInList) {
        output += formatBwImage(event, bwListOptions);
      }

      if (bwListOptions.useImageDiv) {
        output += "</div>";
      }

      if (bwListOptions.useContentDiv) {
        output += "<div class=\"bwEventContent\">";
      }
      // output date and summary either byDate first or byTitle first
      if (bwListOptions.listMode === 'byDate') {
        output += formatBwDateTime(event, bwListOptions)
            + "<br/>"
            + formatBwSummary(event,outputContainerID, i, bwListOptions);
      } else {
        output += formatBwSummary(event,outputContainerID, i ,bwListOptions)
            + "<br/>"
            + formatBwDateTime(event,bwListOptions);
      }

      // add locations
      if (bwListOptions.displayLocationInList) {
        output += "<div class=\"bwLoc\">"
            + "<span class=\"bwLocTitle\">"
            + bwListOptions.locationTitle
            + "</span> "
            + event.location.address
            + "</div>";
      }

      // add full description
      if (bwListOptions.displayDescription) {
        output += "<div class=\"bwEventDescription\"><p>"
            + event.description.replace(/\n/g,'<br />')
            + "</p></div>";
      }

      // add topical areas
      if (bwListOptions.displayTopicalAreasInList) {
        output += "<div class=\"bwTopicalAreas\">"
            + "<span class=\"bwTaTitle\">"
            + bwListOptions.topicalAreasTitle
            + "</span> ";

        // iterate over the x-properties and pull out the aliases
        for (const j in event.xproperties) {
          if (event.xproperties[j]["X-BEDEWORK-ALIAS"] !== undefined) {
            if (event.xproperties[j]["X-BEDEWORK-ALIAS"].parameters["X-BEDEWORK-PARAM-DISPLAYNAME"] !== undefined) {
              output += event.xproperties[j]["X-BEDEWORK-ALIAS"]
                  .parameters["X-BEDEWORK-PARAM-DISPLAYNAME"]
                  + ", ";
            }
          }
        }

        // trim off the final ", " if we have one
        if (output.endsWith(", ")) {
          output = output.substring(0, output.length - 2);
        }
        output += "</div>";
      }

      if (bwListOptions.useContentDiv) {
        output += "</div>";
      }

      output += "</li>";
    }
    output += "</ul>";
  }
  // Finally, send the output to the container:
  outputContainer.innerHTML = output;
}

function formatBwThumbnail(event,bwListOptions) {
  let output = "";
  let bwEventLink = "";
  let imgPrefix = "";
  let imgSrc = "";
  let imgObj;
  let thumbObj;

  // iterate over the x-properties to see if we have an image or a thumbnail
  for (const i in event.xproperties) {
    if (event.xproperties[i]["X-BEDEWORK-THUMB-IMAGE"] !== undefined) {
      thumbObj = event.xproperties[i]["X-BEDEWORK-THUMB-IMAGE"];
    }
    if (event.xproperties[i]["X-BEDEWORK-IMAGE"] !== undefined) {
      imgObj = event.xproperties[i]["X-BEDEWORK-IMAGE"];
    }
  }

  if (thumbObj !== undefined) {
    // use the thumbnail image
    if (!thumbObj.values.text.startsWith('http')) {
      imgPrefix = bwListOptions.eventImagePrefix;
    }
    imgSrc = imgPrefix + thumbObj.values.text.trim();
  } else if ((imgObj !== undefined) && bwListOptions.useFullImageThumbs) {
    // use the full image for thumbnail
    if (!imgObj.values.text.startsWith('http')) {
      imgPrefix = bwListOptions.eventImagePrefix;
    }
    imgSrc = imgPrefix + imgObj.values.text.trim();
  } else if(bwListOptions.usePlaceholderThumb) {
    // use a placeholder thumbnail
    imgSrc = "/images/calpublic/placeholder.png";
  }

  // did we end up with an image?
  if (imgSrc !== "") {
    if (!imgSrc.startsWith('http')) {
      imgSrc = bwListOptions.calendarServer + imgSrc;
    }
    bwEventLink = getBwEventLink(event,bwListOptions);
    output += "<a href=\"" + bwEventLink + "\">"
        + "<img class=\"eventThumb img-responsive\" width=\""
        + bwListOptions.thumbWidth
        + "\" src=\"" + imgSrc
        + "\" alt=\"" + event.summary
        + "\"/>"
        + "</a>";
  }

  return output;
}

function formatBwImage(event, bwListOptions) {
  let output = "";
  let bwEventLink = "";
  let imgPrefix = "";
  let imgSrc = "";
  let imgObj;
  let imgAlt;

  // iterate over the x-properties to see if we have an image
  for (const i in event.xproperties) {
    if (event.xproperties[i]["X-BEDEWORK-IMAGE"] !== undefined) {
      imgObj = event.xproperties[i]["X-BEDEWORK-IMAGE"];
    }
  }

  if (imgObj !== undefined) {
    if (!imgObj.values.text.startsWith('http')) {
      imgPrefix = bwListOptions.eventImagePrefix;
    }
    imgSrc = imgPrefix + imgObj.values.text.trim();
    if (imgObj.parameters !== undefined) {
      if (imgObj.parameters["X-BEDEWORK-PARAM-ALT"] !== undefined) {
        imgAlt = imgObj.parameters["X-BEDEWORK-PARAM-ALT"];
      }
    }
  }

  // did we end up with an image?
  if (imgSrc !== "") {
    if (!imgSrc.startsWith('http')) {
      imgSrc = bwListOptions.calendarServer + imgSrc;
    }
    bwEventLink = getBwEventLink(event,bwListOptions);
    let alt;
    if (imgAlt !== undefined) {
      alt = imgAlt;
    } else {
      alt = event.summary;
    }
    output += "<a href=\"" + bwEventLink + "\">"
        + "<img class=\"eventImage img-responsive\""
        + " src=\"" + imgSrc + "\""
        + " alt=\"" + alt + "\""
        + "/>"
        + "</a>";
  }

  return output;
}

function formatBwDateTime(event,bwListOptions) {
  let output = "<span class=\"bwDateTime\">";

  if (bwListOptions.listMode === 'byDate') {
    output +="<strong>";
  }

  /**
   * @property {string} event.start.dayname
   * @property {string} event.start.allday
   * @property {string} event.start.time
   * @property {string} event.start.longdate
   * @property {string} event.start.shortdate
   */
  if (!bwListOptions.suppressStartDateInList) {
    // display the start date
    if (bwListOptions.displayDayNameInList) {
      if (bwListOptions.displayDayNameTruncated) {
        output += event.start.dayname.substring(0, 3);
      } else {
        output += event.start.dayname;
      }
      output += ", ";
    }

    output += event.start.longdate;
    if ((event.start.allday === 'false') && bwListOptions.displayTimeInList) {
      output += " " + event.start.time;
    }
  }
  if (!bwListOptions.suppressEndDateInList) {
    if (bwListOptions.suppressStartDateInList) {
      output += bwListOptions.untilText + " ";
    }
    if (bwListOptions.displayEndDateInList) {
      if (event.start.shortdate !== event.end.shortdate ||
          bwListOptions.suppressStartDateInList) {
        if(!bwListOptions.suppressStartDateInList) {
          output += " - ";
        }
        if (bwListOptions.displayDayNameInList) {
          if (bwListOptions.displayDayNameTruncated) {
            output += event.end.dayname.substring(0, 3);
          } else {
            output += event.end.dayname;
          }
          output += ", ";
        }
        output += event.end.longdate;
        if ((event.start.allday === 'false') &&
            bwListOptions.displayTimeInList) {
          output += " " + event.end.time;
        }
      } else if ((event.start.allday === 'false') &&
          bwListOptions.displayTimeInList &&
          (event.start.time !== event.end.time)) {
        // same date, different times
        output += " - " + event.end.time;
      }
    }
  }

  if (bwListOptions.listMode === 'byDate') {
    output +="</strong>";
  }
  output += "</span>";

  return output;
}

function formatBwSummary(event, outputContainerID, i, bwListOptions) {
  let output = "<span class=\"bwSummary\">";

  if (bwListOptions.listMode === 'byTitle') {
    output +="<strong>";
  }

  if (bwListOptions.displayEventDetailsInline) {
    // don't link back to the calendar - display event details in the widget
    output += "<a href=\"javascript:showBwEvent('"
        + outputContainerID
        + "',"
        + i
        + ");\">"
        + event.summary
        + "</a>";
  } else {
    // link back to the calendar
    const bwEventLink = getBwEventLink(event,bwListOptions);

    output += "<a href=\"" + bwEventLink + "\">" + event.summary +
        "</a>";
  }

  if (bwListOptions.listMode === 'byTitle') {
    output +="</strong>";
  }
  output += "</span>";

  return output;
}

/**
 * @param {object} event
 * @param {object} event.contact
 * @param {object} event.xproperties
 * @param {string} event.subscriptionId
 * @param {string} event.calPath
 * @param {string} event.categories
 * @param {string} event.guid
 * @param {string} event.cost
 * @param {string} event.recurrenceId
 * @param {object} bwListOptions
 */
function getBwEventLink(event, bwListOptions) {
  // Include the urlPrefix for links back to events in the calendar.
  const urlPrefix = bwListOptions.calendarServer
      + bwListOptions.calSuiteContext
      + "/event/eventView.do";

  // generate the query string parameters that get us back to the
  // event in the calendar:
  let eventQueryString = "?subid=" + event.subscriptionId
      + "&amp;calPath=" + event.calPath
      + "&amp;guid=" + event.guid
      + "&amp;recurrenceId=" + event.recurrenceId;

  return urlPrefix + eventQueryString;
}

/* Display an event inline: DEPRECATED */
function showBwEvent(outputContainerID, eventId, displayContact,
                     displayCost, displayTags,
                     displayTimezone) {
  // Style further with CSS

  // Rudimentary options (this should be improved by turning the entire list
  // into an object with a method to get the options.  This will do for now.)
  let displayContactInDetails = true;
  let displayCostInDetails = true;
  let displayTagsInDetails = true;
  let displayTimezoneInDetails = true;

  if ((displayContact !== undefined) && displayContact.length) {
    displayContactInDetails = displayContact;
  }
  if ((displayCost !== undefined) && displayCost.length) {
    displayCostInDetails = displayCost;
  }
  if ((displayTags !== undefined) && displayTags.length) {
    displayTagsInDetails = displayTags;
  }
  if ((displayTimezone !== undefined) && displayTimezone.length) {
    displayTimezoneInDetails = displayTimezone;
  }

  const outputContainer = document.getElementById(outputContainerID);
  // provide a shorthand reference to the event:
  /**
   * @property {object} event
   * @property {string} event.summary
   * @property {object} event.location
   * @property {string} event.location.link
   */
  const event = bwObject.bwEventList.events[eventId];

  // create the event
  let output = "<h3 class=\"bwEventsTitle\">" + event.summary
      + "</h3>"
      + "<div class=\"bwEventLogistics\">"

      // output date/time
      + "<div class=\"bwEventDateTime\">"
      + event.start.longdate;

  if (event.start.allday === 'false') {
    output += " " + event.start.time;
    if ((event.start.timezone !== event.end.timezone) &&
        displayTimezoneInDetails) {
      output += " " + event.start.timezone;
    }
  }

  if (event.start.shortdate !== event.end.shortdate) {
    output += " - "
        + event.end.longdate;
    if (event.start.allday === 'false') {
      output += " " + event.end.time;
      if (displayTimezoneInDetails) {
        output += " " + event.end.timezone;
      }
    }
  } else if ((event.start.allday === 'false') &&
      (event.start.time !== event.end.time)) {
    // same date, different times
    output += " - " + event.end.time;
    if (displayTimezoneInDetails) {
      output += " " + event.end.timezone;
    }
  }
  output += "</div>";

  // output location
  output += "<div class=\"bwEventLoc\">";
  if (event.location.link !== "") {
    output += "<a href=\""+ event.location.link + "\">"
        + event.location.address + "</a>";
  } else {
    output += event.location.address;
  }
  output += "</div>";

  // output description
  output += "<div class=\"bwEventDesc\">"
      + event.description.replace(/\n/g,'<br />')
      + "</div>";

  // output contact
  if (displayContactInDetails) {
    output += "<div class=\"bwEventContact\">";
    if (event.contact.link !== "") {
      output += "Contact: <a href=\"" + event.contact.link + "\">"
          + event.contact.name + "</a>";
    } else {
      output += "Contact: " + event.contact.name;
    }
    output += "</div>";
  }

  // output cost
  if ((event.cost !== "") && displayCostInDetails) {
    output += "<div class=\"bwEventCost\">"
        + "Cost: " + event.cost
        + "</div>";
  }

  // output tags (categories)
  if ((event.categories !== "") && displayTagsInDetails) {
    output += "<div class=\"bwEventCats\">"
        + "Tags: " + event.categories
        + "</div>";
  }

  // output link
  if (event.link !== "") {
    output += "<div class=\"bwEventLink\">"+ "See: "
        + "<a href=\"" + event.link + "\">"
        + event.link + "</a>"
        + "</div>";
  }
  output += "</div>";

  // create a link back to the main view
  output += "<p class=\"bwEventsListLink\">"
      + "<a href=\"javascript:insertBwEvents('"
      + outputContainerID
      + "')\">Return</a></p>";

  // Send the output to the container:
  outputContainer.innerHTML = output;
}