
import 'package:googleapis_auth/auth_io.dart';

class GetServiceKey{
  Future<String> getServiceKey() async {

    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({

          "type": "service_account",
          "project_id": "ecommerceapp-a21e1",
          "private_key_id": "f1baf38d3a97b93dcb8c4e56ebc95c7f8be3f633",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDRWk95Ywx53/k+\nq2hSYRimHz6xhJgvD/u/ObnTP4Nfxsm6oc2EwjEsl3resCYgNUbNV6tlV4ZJCjl6\n2XOWZSiv1tHW5/8TNsxwRm26KRmkpoe8j6G//3ET7ygcXUhKdb/wxeTi6yumRMx2\nS4mm+K8IuK5wYhkYxFacxqBfy6AEdWgU5yfg6tlcgpUx7SIfvMhCQ4ymS1Y/nG3K\nReczwYppwNLeI6yhcJ2dV/PUT/FRE8URyBO145xl/zODCIP3CwjGTKjAJ6oCKvg8\nvHiTbPtcXwbuOWeL2pcYb6Sh3obVy5K36JF6qzKfiDK8A2YCFZXoLwXMpHfniJDk\nqSOXoTPRAgMBAAECggEAAfhcWptWxPfZX+BbkzjkMz4EiEWj6/91wkswBz+oBBj6\nEYZPyZHNRirnxlw4g6GUuL58N7Au7JWKzG/q8U2i6CK4p1HYGe1wV5cmFbQo0F6b\n1OeyIT0tan9b7IZpNYAtrf2ixYrqhn5LwUo9MaPR+95HD/owW8YPPZr16+jd6OTQ\nmRUkaes3OCy80mhArgU4BdWbL1jZe3+yPL09fN8BCin1T3ROe26vtR2IXmborOPN\nbzQBpCCyKKp3K4W7XDClfYPlWWP4lBoS+F3bdwHZFcFH0J2/a6tVECNLtbs5IAHG\n7KPdKFDy4DcOnupuU7gN8mUb/V71QjkngJ3O2OfcVQKBgQDyLFzbr/a4D0XKOknC\noMPnAzl+FC/Vw/A03rjyl09jpR7rcg4J2/kbQxFOBpawMaXA7c2KQrTERBsJQyph\n4/tLSqR9XNm+oVwp45Vyx00NjBZxER/bs9BCaJub5Qrtl0U4+wV0+fCxyNuZZ9Ep\n2Uv6YCwwua/0z84McXw/kd/sfQKBgQDdTj0YLV8pwKW0mML8mAXVSmaB+2tfIdZ2\nYOxu6NLm4UYUFFm8MxTer668Preqbcj9zul6w0HRpvnryP0AYbdbdRAZa647CwfZ\neelZffXCmkZ7IknIr/vqBh6aoGvjcqhqYBnhzFUk7zETydmDzU/RGPQ/p14YjLaV\nkDSwQaXI5QKBgF519WZvlYGn22YNJFY5VRCXzmYiQ6JTAi/tLCDb6kiI0K2v2E/6\nMIl0uJxBr6dcRjYhy8mBSXdAxXbwbuit/4gXvl9zxy83S3a/YbzahnChUuOZdV7C\nHZq5qPC+/2s7VPHr3+4Hy93c5eNJfmmfa6ZmuvXqh/qqz8lEvt0g7kIVAoGBAKJz\niE1zIOQZUopbiOa7Aa0sTEsmMA9JW5DSXTydFBP/Ud3zgluwc6Vz+SSeNVyZ8my9\nso43Pt2TYOpAQ9g/4sT0DblbXi5hToXKBA15dSpA7XP+G4OCC74id9yx3gC8bfyI\nRveFcwsFulT4Wv9xeyHW25TOWzhSMsVfcg3gYr4xAoGAPAOIstZiVVaOUVlXbbw9\n66T2hchjxL+SMaOciXL5KHatyesfHfMgYfo6GaX/HLs9hYJi9NCtoEmVVvkZmodA\nOdRD+1cg5xPEYqNM+ZouM0W5eZf9JMOqBXptjkqNiuYZyxLV7ag90HbsB0xAGhyP\nwyHD7gaMCIng/ySs1uFDJFc=\n-----END PRIVATE KEY-----\n",
          "client_email": "firebase-adminsdk-9ozbv@ecommerceapp-a21e1.iam.gserviceaccount.com",
          "client_id": "107623200479722866412",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-9ozbv%40ecommerceapp-a21e1.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accessserverkey = client.credentials.accessToken.data;
    return accessserverkey;
  }
}