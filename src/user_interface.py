import time

from tabulate import tabulate

from src.classes.national_park import NationalPark
from src.classes.user import User
from src.utils.utils import *


class UserInterface:
    def __init__(self, db):
        self.current_user = User()
        self.db = db
        self.options = [
            'Discover Services',
            'Book a Service',
            'Cancel a Booking',
            'Provide Feedback for Service',
            'Provide Feedback for a Feature',
            'Update your Profile',
            'Find Nearby Features',
            'Exit'
        ]
        self.functions = [
            self.discover,
            self.do_a_booking,
            self.cancel_booking,
            self.give_service_feedback,
            self.give_feature_feedback,
            self.update_user,
            self.nearby
        ]
        self.curr_opt = 0

    def create_user(self):
        try:
            self.current_user = User()
            query = self.current_user.create()
            self.db.execute_query([query])
            return True

        except Exception as e:
            perror('An error occurred')
            inp = input('Press Enter to continue >> ')

    def update_user(self):
        print_header("Update Profile")
        newUser = User()
        repeat_and_error(newUser.get_name)()
        repeat_and_error(newUser.get_password)()
        repeat_and_error(newUser.get_contact)()

        query = ["UPDATE User SET username = '{}' , password = '{}' , " \
                 "contact_number = '{}' where user_id = {}".format(
            newUser.username, newUser.password,
            newUser.contact_number, self.current_user.user_id)]

        res = self.db.execute_query(query)
        if res:
            self.current_user.username = newUser.username
            self.current_user.password = newUser.password
            self.current_user.contact_number = newUser.contact_number
        inp = input('\nPress ENTER to continue >> ')

    def login_user(self):
        query = self.current_user.login()

        rows = self.db.get_result(query)

        if len(rows) == 1:
            rows = rows[0]
            self.current_user.user_id = rows['user_id']
            self.current_user.username = rows['username']
            self.current_user.email = rows['email']
            self.current_user.password = rows['password']
            self.current_user.contact_number = int(rows['contact_number'])
            self.current_user.dob = rows['date_of_birth']
            return True
        else:
            perror("Not a valid User, try again")
            return False

    def choose_options(self):
        self.curr_opt = int(input(
            'Enter the corresponding option for which activity you want to perform: '))
        if not syntax.validate_range(self.curr_opt, 1, len(self.options)):
            perror("must be from one of the options")
            return False
        else:
            return True

    def discover(self):
        try:
            while True:
                print_header('Discover')
                national_list = "SELECT unit_code, name from National_Park"
                rows = self.db.get_result(national_list)
                print('Here are the National Parks')
                i = 0
                for row in rows:
                    print('{}. {}'.format(i + 1, row['name']))
                    i += 1
                unit_code = int(input(
                    'Enter the corresponding number of the National Park you want to Discover: '))
                if not syntax.validate_range(unit_code, 1, len(rows)):
                    perror('invalid Input')
                    return
                target_np = rows[unit_code - 1]

                print_header('Discover')
                service_list = "SELECT service_id, name, description from Services where provided_by ='{}' ".format(
                    target_np['unit_code'])
                rows = self.db.get_result(service_list)
                if len(rows) == 0:
                    print(
                        "Sorry No services are available in this National Park,",
                        " Kindly wait while we send you back to main screen")
                    time.sleep(5)
                    continue
                print("Here's a list of services in", target_np['name'])
                i = 0
                for row in rows:
                    print('{}. {}: \nAbout : {}'.format(i + 1, row['name'],
                                                        row['description']))
                    i += 1
                service_code = int(input(
                    'Enter the corresponding number of the service you want to read about: '))
                if not syntax.validate_range(service_code, 1, len(rows)):
                    perror('invalid Input')
                    return
                target_service = rows[service_code - 1]

                print_header('Discover')
                print("Name: " + target_service['name'] + " at " + target_np[
                    'name'] + "\nAbout: " + target_service[
                          'description'])

                qq = "select AVG(rating) from Service_Feedback where service_id = {}".format(
                    target_service['service_id'])

                rows = self.db.get_result(qq)

                if rows[0]['AVG(rating)'] is not None:
                    print("Cumulative Rating: " + str(rows[0]['AVG(rating)']))

                qq = "select User.username, Service_Feedback.rating, Service_Feedback.remarks, Service_Feedback.date " \
                     "from Service_Feedback inner join User on Service_Feedback.user_id = User.user_id " \
                     "where service_id = {} order by rating".format(target_service['service_id'])

                rows = self.db.get_result(qq)

                print(tabulate(rows, headers="keys"))

                print('Do you want to continue to Discover? (y/n): ')
                ans = input()
                if ans.lower() != 'y':
                    break

        except Exception as q:
            perror('An error occurred in fetching')
            inp = input('Press ENTER to continue>> ')

    def do_a_booking(self):
        global booking_id
        try:
            print_header('Booking')
            adult = to_int(input("Enter number of adults in the party: "))
            children = to_int(input("Enter the number of Children in the party: "))
            if adult is None or adult <= 0:
                adult = 1

            qq = "INSERT INTO Booking(user_id, number_of_adults, number_of_children) VALUES({}, {}, {})".format(
                self.current_user.user_id, adult, children)

            self.db.execute_query([qq])

            rows = self.db.get_result("SELECT LAST_INSERT_ID();")

            booking_id = rows[0]['LAST_INSERT_ID()']

            total_price = 0

            chosen = []

            q = []

            print_header('Booking')
            national_list = "SELECT unit_code, name from National_Park"
            rows = self.db.get_result(national_list)
            print('Here are the National Parks')
            i = 0
            for row in rows:
                print('{}. {}'.format(i + 1, row['name']))
                i += 1
            unit_code = int(input(
                'Enter the corresponding number of the National Park you want to book: '))
            if not syntax.validate_range(unit_code, 1, len(rows)):
                perror('invalid Input')
                return
            target_np = rows[unit_code - 1]

            while True:
                # Get target National Park
                # Get target Service
                print_header('Booking')
                service_list = "SELECT service_id, name, description from Services where provided_by ='{}' ".format(
                    target_np['unit_code'])
                rows = self.db.get_result(service_list)
                if len(rows) == 0:
                    print(
                        "Sorry No services are available in this National Park")
                    time.sleep(5)
                    continue
                print("Here's a list of services in", target_np['name'])
                i = 0
                for row in rows:
                    print('{}. {}: \n {}'.format(i + 1, row['name'],
                                                 row['description']))
                    i += 1
                service_code = int(input(
                    'Enter the corresponding number of the service you want to book: '))
                if not syntax.validate_range(service_code, 1, len(rows)):
                    perror('invalid Input')
                    return
                target_service = rows[service_code - 1]

                # Get target Sub_service
                print_header('Booking')
                timings_list = "SELECT sub_service_id, timings from Sub_service where service_id ='{}'" \
                               " order by timings".format(target_service['service_id'])
                rows = self.db.get_result(timings_list)
                if len(rows) == 0:
                    print("Sorry we couldn't find services that are available")
                    time.sleep(2.5)
                    continue
                print("Here's a list of timings of", target_service['name'])
                i = 0
                for row in rows:
                    print('{}. {}'.format(i + 1, row['timings']))
                    i += 1
                sub_service_code = int(input(
                    'Enter the corresponding number of the timings of the service you want to book: '))
                if not syntax.validate_range(sub_service_code, 1, len(rows)):
                    perror('invalid Input')
                    return
                target_sub_service = rows[sub_service_code - 1]

                # Get target Date
                print_header('Booking')
                dates_list = "SELECT date, price from Sub_service_timings where availability >= {}" \
                             " AND sub_service_id = {} and date > DATE(NOW()) ORDER BY date". \
                    format(adult,
                           target_sub_service[
                               'sub_service_id'])
                rows = self.db.get_result(dates_list)
                if len(rows) == 0:
                    print("Sorry No services are available")
                    time.sleep(5)
                    continue
                print("Here's a list of dates which are available and the corresponding prices: ")
                i = 0
                for row in rows:
                    print('{}.|  {}  | Rs.{} per adult'.format(i + 1, row['date'], row['price']))
                    i += 1
                date_code = int(input(
                    'Enter the corresponding number of the date you want to book for: '))
                if not syntax.validate_range(sub_service_code, 1, len(rows)):
                    perror('invalid Input')
                    return
                target_date = rows[date_code - 1]

                total_price += target_date['price'] * adult
                chosen.append(
                    '{} for Rs.{} at {} on {} for {} adults'.format(target_service['name'], target_date['price'],
                                                                    target_sub_service['timings'],
                                                                    target_date['date'], adult))

                qq = "INSERT INTO Booking_service(booking_id, sub_service_id, price, target_date)" \
                     "VALUES ({}, {}, {}, '{}')".format(booking_id,
                                                        target_sub_service['sub_service_id'],
                                                        target_date['price'],
                                                        target_date['date'])
                q.append(qq)

                qq = "UPDATE Sub_service_timings SET availability = availability - 1" \
                     " where sub_service_id = {} AND date = '{}' AND availability > 0;".format(
                    target_sub_service['sub_service_id'], target_date['date'])

                q.append(qq)

                ans = input('Do you want to continue to book services? (y/n): ')
                if ans.lower() != 'y':
                    break
            print("\n\n\nHere's Your INVOICE\n")
            for i in chosen:
                print(i)
            print("\n\nTotal Expenses:", total_price)
            print('\n\nDo you want to book the above services? (y/n): ')
            ans = input()
            if ans.lower() != 'y':
                print('The booking was cancelled')
                qq = "DELETE FROM Booking where booking_id = {}".format(
                    booking_id)
                self.db.execute_query([qq])
                inp = input('press ENTER to continue >>')
                return
            if self.db.execute_query(q):
                psuccess("\n\nCongratulations, your Booking was a success")
            inp = input('press ENTER to continue >>')

        except (ValueError, Exception) as q:
            qq = "DELETE FROM Booking where booking_id = {}".format(booking_id)
            self.db.execute_query([qq])
            print(type(q))
            inp = input('Press ENTER to continue >> ')

    def cancel_booking(self):
        try:
            while True:
                qq = "SELECT DISTINCT B.booking_id, B.number_of_adults, B.number_of_children , S.name," \
                     " SS.sub_service_id, SS.timings, BS.target_date, BS.price from " \
                     " Booking B, Booking_service BS, Sub_service SS, Services S" \
                     " WHERE B.user_id  = {} and BS.sub_service_id = SS.sub_service_id " \
                     " and B.booking_id = BS.booking_id and S.service_id = SS.service_id" \
                     " and BS.target_date > DATE(NOW())".format(self.current_user.user_id)

                rows = self.db.get_result(qq)

                if len(rows) == 0:
                    print("Sorry we couldn't find any bookings by you,",
                          "You will now be transferred back to the main screen")
                    time.sleep(2.5)
                    return

                print_header('Cancellation')

                print(tabulate(rows, headers='keys', showindex='always'))

                booking_code = int(input(
                    'Enter the corresponding number of the booking you want to cancel: '))
                if not syntax.validate_range(booking_code, 0, len(rows) - 1):
                    perror('invalid Input')
                    return

                del_booking_id = rows[booking_code]['booking_id']
                del_bs = rows[booking_code]['sub_service_id']
                del_time = rows[booking_code]['target_date']

                qq = "DELETE FROM Booking_service" \
                     " where booking_id = {} and sub_service_id = {} and target_date = '{}'".format(
                    del_booking_id,
                    del_bs,
                    del_time)

                self.db.execute_query([qq])
                psuccess(
                    'The Cancellation was a success. The amount will be returned in a few days')

                rows = self.db.get_result("SELECT * FROM Booking_service where booking_id = {}".format(del_booking_id))

                if len(rows) == 0:
                    qq = "DELETE FROM Booking" \
                         " where booking_id = {}".format(
                        del_booking_id)
                    self.db.execute_query([qq])

                print(
                    'Do you want to continue to cancel your prior bookings? (y/n): ')
                ans = input()
                if ans.lower() != 'y':
                    break

        except Exception as q:
            print(type(q))
            inp = input('Press ENTER to continue >> ')

    def give_service_feedback(self):
        try:
            q = []
            while True:
                print_header('Feedback')
                national_list = "SELECT unit_code, name from National_Park"
                rows = self.db.get_result(national_list)
                print('Here are the National Parks')
                i = 0
                for row in rows:
                    print('{}. {}'.format(i + 1, row['name']))
                    i += 1
                unit_code = int(
                    input(
                        'Enter the corresponding number of the National Park you want to provide feedback for: '))
                if not syntax.validate_range(unit_code, 1, len(rows)):
                    perror('invalid Input')
                    return
                target_np = rows[unit_code - 1]

                print_header('Feedback')
                service_list = "SELECT service_id, name, description from Services where provided_by ='{}' ".format(
                    target_np['unit_code'])
                rows = self.db.get_result(service_list)
                if len(rows) == 0:
                    print(
                        "Sorry we couldn't find services that are available,",
                        "You will now be transferred back to the main screen")
                    time.sleep(2.5)
                    continue

                print("Here's a list of services offered by",
                      target_np['name'])
                i = 0
                for row in rows:
                    print('{}. {}: \n {}'.format(i + 1, row['name'],
                                                 row['description']))
                    i += 1

                service_code = int(
                    input(
                        'Enter the corresponding number of the service you want to provide feedback for: '))
                if not syntax.validate_range(service_code, 1, len(rows)):
                    perror('invalid Input')
                    return
                target_service = rows[service_code - 1]

                test = self.db.get_result('SELECT * FROM Service_Feedback where user_id = {} and '
                                          'service_id = {}'.format(f(self.current_user.user_id),
                                                                   f(target_service['service_id'])))
                if not syntax.empty(test):
                    print('You have already provided feedback for that service, Try Again.')
                    inp = input('Press Enter to continue')
                    continue

                rating = int(input(
                    'Enter the rating you would like to give to {}: '.format(
                        target_service['name'])))

                if not syntax.validate_range(rating, 1, 5):
                    perror('invalid Input')
                    return

                print("Enter your remarks if any: ")
                remarks = input()

                qq = "INSERT INTO Service_Feedback(user_id, service_id, rating, remarks, date)" \
                     "VALUES({},{},{},'{}',NOW())".format(self.current_user.user_id, target_service['service_id'],
                                                          rating, remarks)

                q.append(qq)

                print('Do you want to continue give feedback? (y/n): ')
                ans = input()
                if ans.lower() != 'y':
                    break

            self.db.execute_query(q)
            psuccess("Congratulations, your feedback was recorded")
            time.sleep(2.5)

        except Exception as q:
            print(type(q))
            time.sleep(5)

    def give_feature_feedback(self):
        try:
            q = []
            while True:
                print_header('Feature Feedback')
                national_list = "SELECT unit_code, name from National_Park"
                rows = self.db.get_result(national_list)
                print('Here are the National Parks')
                i = 0
                for row in rows:
                    print('{}. {}'.format(i + 1, row['name']))
                    i += 1
                unit_code = int(
                    input('Enter the corresponding number of the National Park you want to provide feedback for: '))
                if not syntax.validate_range(unit_code, 1, len(rows)):
                    perror('invalid Input')
                    return
                target_np = rows[unit_code - 1]

                rows = []
                print_header('Feature Feedback')
                feature_list = 'SELECT Z.zone_number, Z.feature_id, F.feature_name, T.name as type FROM Features F,' \
                               ' Lodging T,' \
                               ' Zone_contains Z where F.feature_id = Z.feature_id and T.feature_id = F.feature_id' \
                               ' and Z.belongs_to = {}'.format(f(target_np['unit_code']))
                temp = self.db.get_result(feature_list)
                rows += temp
                feature_list = 'SELECT Z.zone_number, Z.feature_id, F.feature_name, T.name as type FROM Features F, Trail T,' \
                               ' Zone_contains Z where F.feature_id = Z.feature_id and T.feature_id = F.feature_id' \
                               ' and Z.belongs_to = {}'.format(f(target_np['unit_code']))
                temp = self.db.get_result(feature_list)
                rows += temp
                feature_list = 'SELECT Z.zone_number, Z.feature_id, F.feature_name, T.name as type FROM Features F,' \
                               ' ViewPoints T,' \
                               ' Zone_contains Z where F.feature_id = Z.feature_id and T.feature_id = F.feature_id' \
                               ' and Z.belongs_to = {}'.format(f(target_np['unit_code']))
                temp = self.db.get_result(feature_list)
                rows += temp
                feature_list = 'SELECT Z.zone_number, Z.feature_id, F.feature_name, T.name as type FROM Features F, ' \
                               'Public_Facilities T,' \
                               ' Zone_contains Z where F.feature_id = Z.feature_id and T.feature_id = F.feature_id' \
                               ' and Z.belongs_to = {}'.format(f(target_np['unit_code']))
                temp = self.db.get_result(feature_list)
                rows += temp
                if len(rows) == 0:
                    print("Sorry we couldn't find features that are available,",
                          "You will now be transferred back to the main screen")
                    imp = input('Press Enter to continue>>')
                    continue

                print(tabulate(rows, headers='keys', showindex='always'))
                feature_code = int(
                    input('Enter the corresponding number of the feature you want to provide feedback for: '))
                if not syntax.validate_range(feature_code, 0, len(rows) - 1):
                    perror('invalid Input')
                    return
                target_feature = rows[feature_code]

                test = self.db.get_result('SELECT * FROM Feature_Feedback where user_id = {} and '
                                          'feature_id = {}'.format(f(self.current_user.user_id),
                                                                   f(target_feature['feature_id'])))
                if not syntax.empty(test):
                    print('You have already provided feedback for that feature, Try Again.')
                    inp = input('Press Enter to continue')
                    continue

                rating = int(input('Enter the rating you would like to give to {}: '.format(target_feature['name'])))

                if not syntax.validate_range(rating, 1, 5):
                    perror('invalid Input')
                    return

                print("Enter your remarks if any")
                remarks = input()

                qq = "INSERT INTO Feature_Feedback(user_id, feature_id, rating, remarks, date)" \
                     "VALUES({},{},{},'{}',NOW())".format(self.current_user.user_id, target_feature['feature_id'],
                                                          rating, remarks)

                q.append(qq)

                print('Do you want to continue give feedback(y/n)')
                ans = input()
                if ans.lower() != 'y':
                    break

            self.db.execute_query(q)
            psuccess("Congratulations your feedback was recorded")
            imp = input('Press Enter to continue>>')

        except Exception as q:
            perror('An unexpected error occurred')
            imp = input('Press Enter to continue>>')

    def nearby(self):

        print_header("Where am I")

        target_np = NationalPark(self.db)
        target_np.get_national_park()

        print_header("Where am I")

        ch = int(input(
            "Enter 1 if you are on a trail and 2 if you are at another feature: "))

        print_header("Where am I")

        query = ""
        if ch != 1 and ch != 2:
            print("Incorrect choice! Oops...")
            return
        elif ch == 1:
            rows = []
            trail_list = ' SELECT F.feature_name FROM Features F, Trail T,' \
                         ' Zone_contains Z where F.feature_id = Z.feature_id and T.feature_id = F.feature_id' \
                         ' and Z.belongs_to = {}'.format(f(target_np.unitcode))
            rows = self.db.get_result(trail_list)

            if len(rows) == 0:
                print("Sorry we couldn't find trails that are available,",
                      "You will now be transferred back to the main screen")
                time.sleep(2.5)
                return

            print("Here's a list of trails offered by", target_np.name)
            i = 0
            for row in rows:
                print('{}. {}'.format(i + 1, row['feature_name']))
                i += 1

            arg = int(input("Enter the Trail from the above options: "))

            if not syntax.validate_range(arg, 1, len(rows)):
                perror('invalid Input')
                return
            query = " SELECT DISTINCT F.feature_id, F.feature_name" \
                    " FROM Crosses C, Features F, Trail T, Features FF " \
                    " WHERE FF.feature_name = {} AND F.feature_id = C.feature_id " \
                    " AND T.feature_id = C.trail_id and FF.feature_id = T.feature_id".format(
                f(rows[arg - 1]['feature_name']))

        elif ch == 2:

            rows = []
            feature_list = ' SELECT DISTINCT F.feature_name, F.feature_id FROM Features F, ' \
                           ' Zone_contains Z where F.feature_id = Z.feature_id' \
                           ' and Z.belongs_to = {}'.format(f(target_np.unitcode))
            rows = self.db.get_result(feature_list)

            if len(rows) == 0:
                print(
                    "Sorry we couldn't find features that are available,",
                    "You will now be transferred back to the main screen")
                time.sleep(2.5)
                return

            print("Here's a list of features offered by",
                  target_np.name)
            i = 0
            for row in rows:
                print('{}. {}'.format(i + 1, row['feature_name']))
                i += 1

            arg = int(input("Enter the Feature from the above options: "))
            query = " SELECT F.feature_id, F.feature_name FROM Features F WHERE " \
                    " F.geohash LIKE CONCAT((SELECT LEFT(geohash,6) " \
                    " FROM Features K WHERE K.feature_id = {}),'%')".format(rows[arg - 1]['feature_id'])

        print('These are the features nearby to the current location')

        rows = self.db.get_result(query)

        if len(rows) == 0:
            print("None's gonna save you now")
        else:
            print(tabulate(rows, headers="keys", tablefmt="fancy_grid"))

        ans = input('\nPress ENTER to continue')

    def loop(self):
        print("Are you an existing user? (y/n): ")
        ans = input()
        if ans.lower() != 'y':
            print_header('Registration')
            while not self.create_user():
                pass
            psuccess('User successfully created')

        self.current_user = User()

        tmp = sp.call('clear', shell=True)
        f = Figlet(font='slant')
        print(f.renderText('User Login'))

        while True:
            if self.login_user():
                break

        try:
            while True:
                print_header('User Interface')
                for i in range(len(self.options)):
                    print('{}. {}'.format(i + 1, self.options[i]))
                repeat_and_error(self.choose_options)()
                print(self.curr_opt)
                if self.curr_opt == len(self.options):
                    return
                else:
                    self.functions[self.curr_opt - 1]()
        except ValueError as e:
            perror(e)
