var MeetupOpenEvent = Discourse.Model.extend({
  lat: Em.computed.alias('group.group_lat'),
  lon: Em.computed.alias('group.group_lon'),
  link: Em.computed.alias('event_url'),
  members: Em.computed.alias('yes_rsvp_count')
});

MeetupOpenEvent.reopenClass({
  createFromJson: function(events) {
    return _.map(events, function(event) { return MeetupOpenEvent.create(event); });
  }
})

export default MeetupOpenEvent;
