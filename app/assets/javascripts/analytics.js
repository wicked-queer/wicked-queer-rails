wq = {}

wq.track = function(eventName, eventParams) {
  dataLayer.push({
    event: eventName,
    'wq.event': eventParams
  });
}

document.addEventListener("turbolinks:load", function() {
  const events = document.querySelectorAll('[data-event]');
  for (e of events) {
    e.addEventListener('click', trackEvent);
  }

  const pageParameters = document.body.dataset.pageParameters;
  if (pageParameters) {
    parameters = JSON.parse(pageParameters);
    dataLayer.push({
      event: 'wq.pageView', 
      'wq.page': parameters
    });
  }

  const filterForm = document.getElementById('filters');
  if (filterForm) {
    filterForm.addEventListener('submit', submitFilterForm);
  }
});

function trackEvent(event) {
  let parameters = {};
  if (this.dataset.eventParameters) {
    parameters = JSON.parse(this.dataset.eventParameters);
  }
  wq.track(this.dataset.event, parameters);
}

function submitFilterForm(event) {
  event.preventDefault();
  selects = this.querySelectorAll('select');
  checkboxes = [...this.querySelectorAll('input[type="checkbox"]')].filter(checkbox => checkbox.checked);

  filters = {};
  for(select of selects) {
    filters[select.name] = select.value;
  }

  names = [];
  for(checkbox of checkboxes) {
    const name = checkbox.name.replace('[]', '');
    names.push(name);
    if (filters[name]) {
      filters[name].push(checkbox.value);
    } else {
      filters[name] = [checkbox.value];
    }
  }

  names = [...new Set(names)];
  for (name of names) {
    filters[name] = filters[name].join();
  }

  wq.track('wq.eventsFilter', {filters: filters});

  this.submit();  
}
