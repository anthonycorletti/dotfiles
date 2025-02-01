import datetime
from typing import List, Tuple

class YearlyCycles:
    def __init__(self, year: int, bucket_len: int = 6) -> None:
        self.year = year
        self.bucket_len = bucket_len

    def print_buckets(self) -> None:
        year_start = datetime.date.min.replace(year=self.year)
        year_end = datetime.date.max.replace(year=self.year)
        cur_date = year_start
        delta = datetime.timedelta(weeks=self.bucket_len)
        while cur_date <= year_end:
            if cur_date + delta > year_end:
                print(self._print_bucket_string(cur_date, year_end))
            else:
                print(self._print_bucket_string(cur_date, cur_date+delta))
            cur_date = cur_date + delta + datetime.timedelta(days=1)

    def _print_bucket_string(self, start_date: datetime.date, end_date: datetime.date) -> str:
        if start_date <= datetime.datetime.now().date() <= end_date:
            return f"{self._date_format(start_date)} - {self._date_format(end_date)} <"
        return f"{self._date_format(start_date)} - {self._date_format(end_date)}"

    def _date_format(self, date: datetime.date) -> str:
        return datetime.datetime.strftime(date, "%Y-%m-%d")


if __name__ == "__main__":
    yc = YearlyCycles(year=datetime.datetime.now().year)
    yc.print_buckets()
