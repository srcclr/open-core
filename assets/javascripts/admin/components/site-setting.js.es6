import SiteSettingComponent from 'admin/components/site-setting';

const AdditionalCustomTypes = ['textarea'];

export default SiteSettingComponent.reopen({
  partialType: function()  {
    let type = this.get('setting.type');
    return (AdditionalCustomTypes.indexOf(type) !== -1) ? type : this._super();
  }.property('setting.type')
})
