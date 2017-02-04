import moment from 'moment';

moment.locale('ru');

export default {
  date(date) {
    return moment(date).format('dddd, D MMMM');
  },

  dishType(type) {
    switch (type) {
      case 'side_dish':
        return 'Гарниры';
      case 'soup':
        return 'Супы';
      case 'main_dish':
        return 'Основные блюда';
      case 'salad':
        return 'Салаты';
      default:
        return type;
    }
  },
};
