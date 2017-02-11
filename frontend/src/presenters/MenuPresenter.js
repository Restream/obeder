import moment from 'moment';
import dishTypes from 'contants/dishTypes';

moment.locale('ru');

export default {
  date(date) {
    return moment(date).format('dddd, D MMMM');
  },

  dishType(type) {
    switch (type) {
      case dishTypes.side_dish:
        return 'Гарниры';
      case dishTypes.soup:
        return 'Супы';
      case dishTypes.main_dish:
        return 'Основные блюда';
      case dishTypes.salad:
        return 'Салаты';
      case dishTypes.separate_dish:
        return 'Самостоятельное блюдо';
      default:
        return type;
    }
  },
};
