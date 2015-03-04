import Faq from "discourse/routes/faq";

export default Faq.reopen({
  redirect: function() { return this.redirectIfLoginRequired(); }
});
