import moment from 'moment';

moment.locale('ru');

export default {
  date(date) {
    return moment(date).format('dddd, D MMMM');
  },
};
