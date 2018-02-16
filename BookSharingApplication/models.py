from django.db import models
from django.contrib.auth.models import User


class CustomerProfile(models.Model):
    email = models.EmailField(primary_key=True, unique=True)
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    addr1 = models.CharField(max_length=255)
    addr2 = models.CharField(max_length=255)
    city = models.CharField(max_length=255)
    zipcode = models.IntegerField(max_length=5)
    STATE_CHOICES = (
        ('AL','Alabama'),
        ('AK','Alaska'),
        ('AZ', 'Arizona'),
        ('AR', 'Arkansas'),
        ('CA', 'California'),
        ('CO','Colorado'),
        ('CT', 'Connecticut'),
        ('DE', 'Delaware'),
        ('FL', 'Florida'),
        ('GA', 'Georgia'),
        ('HI', 'Hawaii'),
        ('ID', 'Idaho'),
        ('IL', 'Illinois'),
        ('IN', 'Indiana'),
        ('IA', 'Iowa'),
        ('KS', 'Kansas'),
        ('KY', 'Kentucky'),
        ('LA', 'Louisiana'),
        ('ME', 'Maine'),
        ('MD', 'Maryland'),
        ('MA', 'Massachusetts'),
        ('MI', 'Michigan'),
        ('MN', 'Minnesota'),
        ('MS', 'Mississippi'),
        ('MO', 'Missouri'),
        ('MT', 'Montana'),
        ('NE', 'Nebraska'),
        ('NV', 'Nevada'),
        ('NH', 'New Hampshire'),
        ('NJ', 'New Jersey'),
        ('NM', 'New Mexico'),
        ('NY', 'New York'),
        ('NC', 'North Carolina'),
        ('ND', 'North Dakota'),
        ('OH', 'Ohio'),
        ('OK', 'Oklahoma'),
        ('OR', 'Oregon'),
        ('PA', 'Pennsylvania'),
        ('RI', 'Rhode Island'),
        ('SC', 'South Carolina'),
        ('SD', 'South Dakota'),
        ('TN', 'Tennessee'),
        ('TX', 'Texas'),
        ('UT', 'Utah'),
        ('VT', 'Vermont'),
        ('VA', 'Virginia'),
        ('WA', 'Washington'),
        ('WV', 'West Virginia'),
        ('WI', 'Wisconsin'),
        ('WY', 'Wyoming'),
        ('GU', 'Guam'),
        ('PR', 'Puerto Rico'),
        ('VI', 'Virgin Islands')
    )
    state = models.CharField(max_length=2, choices=STATE_CHOICES)
    sec_Code = models.IntegerField(max_length=5)
    verification_Status = models.BinaryField()
    password = models.CharField(max_length=20)


class Lender(models.Model):
    user_Email_Id = models.ForeignKey(
        CustomerProfile,
        on_delete=models.CASCADE,
        primary_key=True,
    )
    ratings = models.DecimalField(decimal_places=1,max_digits=2)
    no_Of_Reviews = models.IntegerField()


class Borrower(models.Model):
    user_Email_Id = models.ForeignKey(
        CustomerProfile,
        on_delete=models.CASCADE,
        primary_key=True,
    )
    ratings = models.DecimalField(decimal_places=1,max_digits=2)
    no_Of_Reviews = models.IntegerField()


class Books(models.Model):
    book_Id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=255)
    author = models.CharField(max_length=255)
    genre = models.CharField(max_length=50)
    user_Email_Id = models.ForeignKey(
        CustomerProfile,
        on_delete=models.CASCADE,
    )
    start_Date_Time = models.DateTimeField()
    end_Date_Time = models.DateTimeField()


class Transaction(models.Model):
    lender_Id = models.ForeignKey(
        CustomerProfile,
        on_delete=models.DO_NOTHING
    )
    book_Id = models.ForeignKey(
        Books,
        on_delete=models.DO_NOTHING
    )
    start_Date = models.DateTimeField(primary_key=True)
    end_Date = models.DateTimeField()
    METHOD = (
        ('HD', 'Home Delivery'),
        ('MCP', 'Meet At Common Point'),
        ('PK', 'Pickup'),
    )
    method_Of_Delivery = models.CharField(max_length=3,choices=METHOD)
    location = models.CharField(max_length=255)
    borrow_Review_Approve = models.BinaryField()
    return_Review_Approve = models.BinaryField()

    class Meta:
        unique_together = ('lender_Id', 'book_Id')


class BorrowRequest(models.Model):
    start_Time = models.DateTimeField()
    end_Time = models.DateTimeField()
    borrower_Email_Id = models.ForeignKey(
        CustomerProfile,
        on_delete=models.DO_NOTHING
    )
    request_Id = models.AutoField(primary_key=True)
