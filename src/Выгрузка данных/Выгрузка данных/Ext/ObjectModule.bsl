﻿

// адрес публикации: http://infostart.ru/public/531285/

Перем мКэшШаблоновВыгрузкиСсылок;

Функция ВыгрузитьТаблицуЗначенийВТабличныйДокумент(ТаблицаСДанными, ТипДанных) Экспорт
	СводныйТабличныйДокумент = Новый ТабличныйДокумент;
	
	ИнициализацияПерменных();
	
	СтруктураТаблиц = ПолучитьСтруктуруТаблицСДанными(ТаблицаСДанными, ТипДанных);
	
	Для Каждого КлючИЗначение Из СтруктураТаблиц Цикл
		ТекущийТипДанных = КлючИЗначение.Ключ;
		ТекущаяТаблицаСДанными = КлючИЗначение.Значение;
		
		ТабличныйДокумент = ЗаполнитьЗаголовокДанных(ТекущийТипДанных);
		СводныйТабличныйДокумент.Вывести(ТабличныйДокумент);
		СводныйТабличныйДокумент.НачатьГруппуСтрок(,Ложь);
		
		ТабличныйДокумент = ВыгрузитьПодготовленнуюТаблицуВТабличныйДокумент(ТекущаяТаблицаСДанными);
		СводныйТабличныйДокумент.Вывести(ТабличныйДокумент);
		
		СводныйТабличныйДокумент.ЗакончитьГруппуСтрок();
	КонецЦикла;
	
	Возврат СводныйТабличныйДокумент;
КонецФункции

Процедура ИнициализацияПерменных()
	мКэшШаблоновВыгрузкиСсылок = Новый Соответствие;
КонецПроцедуры


Функция ПолучитьСтруктуруТаблицСДанными(ТаблицаСДанными, ТипДанных)
	
	ТаблицаСДаннымиКопия = ТаблицаСДанными.Скопировать();
	СтруктураТаблиц = Новый Соответствие;
	СтруктураТаблиц.Вставить(ТипДанных, ТаблицаСДаннымиКопия);
	
	Для Каждого Колонка Из ТаблицаСДанными.Колонки Цикл
		МассивТипов = Колонка.ТипЗначения.Типы();
		Если МассивТипов.Количество() = 0 Тогда
			Продолжить;
		ИначеЕсли НЕ МассивТипов[0] = Тип("ТаблицаЗначений") Тогда
			Продолжить;
		КонецЕсли;
		
		ТаблицаСДаннымиКопия.Колонки.Удалить(Колонка.Имя);
		
		ИмяТипаДанных = ТипДанных + ".ТабличнаяЧасть." + Колонка.Имя;
		СтруктураТаблиц.Вставить(ИмяТипаДанных, СобратьТабличныеЧастиВОднуТаблицуЗначений(ТаблицаСДанными, Колонка.Имя));
	КонецЦикла;
	
	Возврат СтруктураТаблиц;
КонецФункции
Функция СобратьТабличныеЧастиВОднуТаблицуЗначений(ТаблицаШапок, ИмяТабличнойЧасти)
	
	Если ТаблицаШапок.Количество() = 0 Тогда
		СводнаяТаблица = Новый ТаблицаЗначений;
		СводнаяТаблица.Колонки.Добавить("Ссылка");
	Иначе
		СводнаяТаблица = ТаблицаШапок[0][ИмяТабличнойЧасти].Скопировать(Новый Массив); // копируем структуру
	КонецЕсли;
	
	
	Для Каждого СтрокаШапки Из ТаблицаШапок Цикл
		Для Каждого СтрокаТабличнойЧасти Из СтрокаШапки[ИмяТабличнойЧасти] Цикл
			ЗаполнитьЗначенияСвойств(СводнаяТаблица.Добавить(),СтрокаТабличнойЧасти);
		КонецЦикла;
	КонецЦикла;
	
	Возврат СводнаяТаблица;
КонецФункции

Функция ЗаполнитьЗаголовокДанных(ТипДанных)
	
	ТабличныйДокумент = Новый ТабличныйДокумент;
	
	Область = ТабличныйДокумент.Область(2,1);
	Область.Текст = "ТИП";
	Область.Шрифт = Новый Шрифт(,11,Истина);
	Область.ЦветТекста = ЦветаСтиля.ЦветФонаВыделенияПоля;
	
	Область = ТабличныйДокумент.Область(2,2);
	Область.Текст = ТипДанных;
	Область.Шрифт = Новый Шрифт(,,Истина);
	
	Возврат ТабличныйДокумент;
	
КонецФункции

Функция ВыгрузитьПодготовленнуюТаблицуВТабличныйДокумент(ТаблицаСДанными)
	
	ТабличныйДокумент = Новый ТабличныйДокумент;
	ТабличныйДокумент.Область(1,2).Текст = "";
	
	Для Каждого Колонка Из ТаблицаСДанными.Колонки Цикл
		
		ВыгрузитьКолонкуТаблицыВТабличныйДокумент(ТаблицаСДанными, Колонка, ТабличныйДокумент);
		
	КонецЦикла;
	
	Область = ТабличныйДокумент.Область(1,3, ТабличныйДокумент.ВысотаТаблицы, ТабличныйДокумент.ШиринаТаблицы);
	Линия = Новый Линия(ТипЛинииЯчейкиТабличногоДокумента.Сплошная,1);
	Область.ГраницаСверху = Линия;
	Область.ГраницаСнизу = Линия;
	Область.ГраницаСлева = Линия;
	Область.ГраницаСправа = Линия;
	
	Возврат ТабличныйДокумент;
	
КонецФункции

Процедура ВыгрузитьКолонкуТаблицыВТабличныйДокумент(ТаблицаСДанными, Колонка, ТабличныйДокумент)
	
	ВывестиЗаголовокКолонкиВТабличныйДокумент(Колонка, ТабличныйДокумент);
	
	НомерКолонкиТабличногоДокумента = ТабличныйДокумент.ШиринаТаблицы;
	УказыватьТипЯвно = ПустаяСтрока(ТабличныйДокумент.Область(2,НомерКолонкиТабличногоДокумента).Текст);
	
	ТекущийНомерСтрокиТабличногоДокумента = 2;
	Для Каждого Строка Из ТаблицаСДанными Цикл
		ТекущийНомерСтрокиТабличногоДокумента=ТекущийНомерСтрокиТабличногоДокумента+1;
		
		Область = ТабличныйДокумент.Область(ТекущийНомерСтрокиТабличногоДокумента, НомерКолонкиТабличногоДокумента);
		Область.Текст = ПреобразоватьЗначениеВТекст(Строка[Колонка.Имя], УказыватьТипЯвно);
	КонецЦикла;
	
КонецПроцедуры
Процедура ВывестиЗаголовокКолонкиВТабличныйДокумент(КолонкаТаблицыЗначений, ТабличныйДокумент)
	ОбластьИмяКолонки = ТабличныйДокумент.Область(1, ТабличныйДокумент.ШиринаТаблицы + 1);
	ОбластьТипКолонки = ТабличныйДокумент.Область(2, ТабличныйДокумент.ШиринаТаблицы + 1);
	
	ОбластьИмяКолонки.Текст = КолонкаТаблицыЗначений.Имя;
	ОбластьТипКолонки.Текст = ОписаниеТипаСтрокой(КолонкаТаблицыЗначений.ТипЗначения);
	
	ОбластьТипКолонки.ЦветТекста = ЦветаСтиля.ЦветФонаВыделенияПоля;
	
КонецПроцедуры
Функция ОписаниеТипаСтрокой(вхТип)
	МассивТипов = Новый Массив;
	
	Для каждого Тип из вхТип.Типы() Цикл
		Если Тип = Тип("NULL") Тогда
			Продолжить;
		КонецЕсли;
		МассивТипов.Добавить(Тип);
	КонецЦикла;
	
	Если МассивТипов.Количество() <> 1 Тогда
		Возврат "";
	КонецЕсли;
	
	Тип = МассивТипов[0];
	
	ОбъектМетаданных = Метаданные.НайтиПоТипу(Тип);
	Если ОбъектМетаданных = Неопределено Тогда
		Возврат СтрЗаменить(Тип, " ", "");
	КонецЕсли;
	
	ТипСтрокой = ОбъектМетаданных.ПолноеИмя();
	
	Возврат СтрЗаменить(ТипСтрокой, ".", "Ссылка.");
КонецФункции
Функция ПреобразоватьЗначениеВТекст(Значение, УказыватьТипЯвно = Ложь)
	Если ТипЗнч(Значение) = Тип("Строка") Тогда
		Возврат Значение;
	ИначеЕсли ТипЗнч(Значение) = Тип("Число") Тогда
		Возврат Формат(Значение, "ЧРД=.; ЧГ=0");
	ИначеЕсли ТипЗнч(Значение) = Тип("Дата") Тогда
		Возврат Формат(Значение, "ДФ=yyyyMMddHHmmss");
	ИначеЕсли ТипЗнч(Значение) = Тип("Булево") Тогда
		Возврат Строка(Значение);
	ИначеЕсли ТипЗнч(Значение) = Тип("ХранилищеЗначения") Тогда
		Возврат "";
	ИначеЕсли ТипЗнч(Значение) = Тип("УникальныйИдентификатор") Тогда
		Возврат Значение;
	ИначеЕсли ТипЗнч(Значение) = Тип("ОписаниеТипов") Тогда
		Возврат Строка(Значение); // на текущий момент такой тип будет переноситься некорректно
	ИначеЕсли ТипЗнч(Значение) = Тип("ВидСчета") Тогда
		Если Значение = ВидСчета.АктивноПассивный Тогда
			Возврат "=ВидСчета.АктивноПассивный";
		Иначе
			Возврат "=ВидСчета." + Значение;
		КонецЕсли;
	ИначеЕсли НЕ ЗначениеЗаполнено(Значение) Тогда
		Возврат "";
	КонецЕсли;
	
	Возврат СсылкаСтрокой(Значение, УказыватьТипЯвно);
КонецФункции

Функция СсылкаСтрокой(Ссылка, УказыватьТипЯвно)
	
	Если ТипЗнч(Ссылка) = Тип("ВидДвиженияНакопления") Тогда
		Возврат "=ВидДвиженияНакопления."+ Ссылка;
	ИначеЕсли НЕ ЗначениеЗаполнено(Ссылка) Тогда
		Возврат "";
	КонецЕсли;
	
	
	Попытка
		Выражение = ШаблонВыгрузкиСсылки(Ссылка.Метаданные(), УказыватьТипЯвно);
		Возврат Вычислить(Выражение);
	Исключение
		ТекстОшибки = ОписаниеОшибки() + ":["+Выражение+"]";
		Сообщить(ТекстОшибки, СтатусСообщения.Важное);
		Возврат ТекстОшибки;
	КонецПопытки;
	
КонецФункции
Функция ШаблонВыгрузкиСсылки(МетаданныеСсылки, УказыватьТипЯвно)
	
	ШаблонВыгрузкиСсылки = мКэшШаблоновВыгрузкиСсылок.Получить(МетаданныеСсылки);
	Если ШаблонВыгрузкиСсылки = Неопределено Тогда
		Если Метаданные.Справочники.Содержит(МетаданныеСсылки) Тогда
			ШаблонВыгрузкиСсылки = ШаблонВыгрузкиСсылки_Справочник(МетаданныеСсылки);
		ИначеЕсли Метаданные.Документы.Содержит(МетаданныеСсылки) Тогда
			ШаблонВыгрузкиСсылки = ШаблонВыгрузкиСсылки_Документ(МетаданныеСсылки);
		ИначеЕсли Метаданные.Перечисления.Содержит(МетаданныеСсылки) Тогда
			ШаблонВыгрузкиСсылки = ШаблонВыгрузкиСсылки_Перечисление(МетаданныеСсылки);
		ИначеЕсли Метаданные.ПланыВидовХарактеристик.Содержит(МетаданныеСсылки) Тогда
			ШаблонВыгрузкиСсылки = ШаблонВыгрузкиСсылки_Справочник(МетаданныеСсылки);
			ШаблонВыгрузкиСсылки = СтрЗаменить(ШаблонВыгрузкиСсылки, "Справочники.", "ПланыВидовХарактеристик.");
		ИначеЕсли Метаданные.ПланыСчетов.Содержит(МетаданныеСсылки) Тогда
			ШаблонВыгрузкиСсылки = ШаблонВыгрузкиСсылки_Справочник(МетаданныеСсылки);
			ШаблонВыгрузкиСсылки = СтрЗаменить(ШаблонВыгрузкиСсылки, "Справочники.", "ПланыСчетов.");
			ШаблонВыгрузкиСсылки = СтрЗаменить(ШаблонВыгрузкиСсылки, "Ссылка.ЭтоГруппа", "ЛОЖЬ");
		ИначеЕсли Метаданные.ПланыВидовРасчета.Содержит(МетаданныеСсылки) Тогда
			ШаблонВыгрузкиСсылки = ШаблонВыгрузкиСсылки_Справочник(МетаданныеСсылки);
			ШаблонВыгрузкиСсылки = СтрЗаменить(ШаблонВыгрузкиСсылки, "Справочники.", "ПланыВидовРасчета.");
			ШаблонВыгрузкиСсылки = СтрЗаменить(ШаблонВыгрузкиСсылки, "Ссылка.ЭтоГруппа", "ЛОЖЬ");
		ИначеЕсли Метаданные.Задачи.Содержит(МетаданныеСсылки) Тогда
			ШаблонВыгрузкиСсылки = ШаблонВыгрузкиСсылки_Документ(МетаданныеСсылки);
		ИначеЕсли Метаданные.БизнесПроцессы.Содержит(МетаданныеСсылки) Тогда
			ШаблонВыгрузкиСсылки = ШаблонВыгрузкиСсылки_Документ(МетаданныеСсылки);
		Иначе
			ШаблонВыгрузкиСсылки = """""";
		КонецЕсли;
		
		мКэшШаблоновВыгрузкиСсылок.Вставить(МетаданныеСсылки, ШаблонВыгрузкиСсылки);
	КонецЕсли;
	
	Если УказыватьТипЯвно Тогда
		ТипСтрокой = МетаданныеСсылки.ПолноеИмя();
		ТипСтрокой = СтрЗаменить(ТипСтрокой, ".", "Ссылка.");
		ШаблонВыгрузкиСсылки = ШаблонВыгрузкиСсылки + "+""[Т]" + ТипСтрокой+"""";
	КонецЕсли;
	
	Возврат ШаблонВыгрузкиСсылки
	
КонецФункции
Функция ШаблонВыгрузкиСсылки_Справочник(МетаданныеСсылки)
	
	Шаблон_Предопределенный = """=Справочники."+МетаданныеСсылки.Имя+".""+Справочники."+МетаданныеСсылки.Имя+".ПолучитьИмяПредопределенного(Ссылка) + ""//""";
	Если МетаданныеСсылки.ДлинаКода > 0 Тогда
		Шаблон_КодНаименование = "Ссылка.Код";
	ИначеЕсли МетаданныеСсылки.ДлинаНаименования > 0 Тогда
		Шаблон_КодНаименование = "Ссылка.Наименование";
	КонецЕсли;
	
	Шаблон_УникальныйИдентификатор = "+""[У]""+XMLСтрока(Ссылка)";
	ШаблонЭтоГруппа = "+?(Ссылка.ЭтоГруппа,""[Г]"","""")";
	
	Буфер = Новый Структура("СерииКодов");
	ЗаполнитьЗначенияСвойств(Буфер, МетаданныеСсылки);
	Если Буфер.СерииКодов = Метаданные.СвойстваОбъектов.СерииКодовСправочника.ВПределахПодчинения Тогда
		Шаблон_Родитель = "+?(Ссылка.Родитель.Пустая(), """",""[Р]{""+СсылкаСтрокой(Ссылка.Родитель, Истина)+""}"")";
	КонецЕсли;
	
	Буфер = Новый Структура("Владельцы", Новый Массив);
	ЗаполнитьЗначенияСвойств(Буфер, МетаданныеСсылки);
	Если Буфер.Владельцы.Количество() > 0 Тогда
		Шаблон_Владелец = "+""[В]{""+СсылкаСтрокой(Ссылка.Владелец, Истина)+""}""";
	КонецЕсли;
	
	Возврат "?(Ссылка.Предопределенный,"
			+ Шаблон_Предопределенный 
			+ "," 
			+ Шаблон_КодНаименование
			+ Шаблон_УникальныйИдентификатор
			+ ШаблонЭтоГруппа
			+ ?(ЗначениеЗаполнено(Шаблон_Родитель),Шаблон_Родитель, "")
			+ ?(ЗначениеЗаполнено(Шаблон_Владелец),Шаблон_Владелец, "")
			+ ")"
			;
	
КонецФункции
Функция ШаблонВыгрузкиСсылки_Документ(МетаданныеСсылки)
	Возврат "Ссылка.Номер+""[Д]""+Формат(Ссылка.Дата, ""ДФ=yyyyMMdd"")+""[У]""+XMLСтрока(Ссылка)";
КонецФункции
Функция ШаблонВыгрузкиСсылки_Перечисление(МетаданныеСсылки)
	Возврат "ИдентификаторПеречисленияПоСсылке(Ссылка)";
КонецФункции
Функция ИдентификаторПеречисленияПоСсылке(ЗначениеПеречисления) Экспорт
	
	ИмяПеречисления = ЗначениеПеречисления.Метаданные().Имя;
	ИндексЗначенияПеречисления = Перечисления[ИмяПеречисления].Индекс(ЗначениеПеречисления);
	Возврат Метаданные.Перечисления[ИмяПеречисления].ЗначенияПеречисления[ИндексЗначенияПеречисления].Имя;

КонецФункции

