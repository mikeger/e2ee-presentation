footer: UIKonf 2018 • mihail@gerasimenko.me • @GerasimenkoMiha
autoscale: true
## **E2EE**
## [End-to-End Encryption]
## for iOS Developer.
### Mike Gerasymenko, Wire
	
^ Good morning UIKonf! My name is Mike Gerasymenko. Today I want to talk with you about something that I am working professionally with every day for quite some time. It's called _End-to-End encryption_. Don't worry just yet, over the course of this talk I'll explain what it means and why someone might need it. But first things first, let's get introduced.

---
# Introduction.

- Master of Applied Mathematics at Odessa State `I.I.Mechnikov` University.
- 9 years in iOS development.
- 5 years Berliner.

^ I studied applied mathematics at Odessa State University, since then worked on quite some projects. I am working and living in Berlin for quite some time now.

---

> Privacy is the fundamental human right.
-- Agis Tsaraboulidis

---
# Forbidding reality.

Recently everyone seem to be willing to forbid the end-to-end encrypted messaging. How this can be achieved?

- Forbid Mathematics.
- Forbid Apps.
- Block the Internet.
- Backdoor it.

^ I want to speak about forbidding the encryption thing. Recently everyone seem to be willing to forbid the end-to-end encrypted messaging. There are several ways it can be achieved. Those are to forbid the mathematics, forbid the apps, or more precisely the app stores, forbid the internet access for the messaging apps or simply force to backdoor the apps.

---
# Forbidding reality: does not work ❌.

Recently everyone seem to be willing to forbid the end-to-end encrypted messaging. How this can be achieved?

- Forbid Mathematics - if it would be possible :)
- Forbid Apps - trying: 🇨🇳 ❌.
- Block the Internet - trying: 🇨🇳, 🇷🇺, 🇮🇷... ❌.
- Backdoor it - trying: 🇬🇧, ... ❌.

^ Different countries are trying to find their path to forbid the reality and find the way for citizens not to use the end to end encrypted apps. Lucky enough no one is trying to forbid the math behind the encryption. Some are removing the apps from the app stores, but it does not really work. Some are blocking the server IP addresses, but it is really easy to use VPN or the proxy. Some "besorgte bürger" concerned citizens are trying to make apps include the backdoor to find the way to bypass the encryption. Lucky enough Wire is safe being under the Swiss jurisdiction.

---
## Bottomline.
![](images/stasi.jpg)

### Forbidding encrypted messaging would not work. 
### Invention is not possible to forbid.

^ Forbidding encrypted messaging would not work. Invention is not possible to forbid.

---
# Motivation.

## Why I am giving this talk?

- Help to understand what the end-to-end encryption is exactly about.

^ So why I am giving this talk, again? I am happy to share my knowledge in the topic. This includes some basic understanding what the end to end encryption is.

---
# Motivation.

## Why I am giving this talk?

- Help to understand what the end-to-end encryption is exactly about.
- Motivate to think about privacy when implementing the apps.

^ I hope it can inspire more developers to take this approach or utilize it not only developing the messaging apps but also when working on the other solutions. Part of the motivation is of course to share the experience I've had while working in my current company: Wire.

---
# Motivation.

## Why I am giving this talk?

- Help to understand what the end-to-end encryption is exactly about.
- Motivate to think about privacy when implementing the apps.
- Inspire to create the new E2EE apps.
 
^ And certainly to inspire the creation of the new end to end encrypted apps, and this is not only about the messaging.
 
---
![fit original](images/wired.png)

^ By the way, I work at W-i-r-e. Oh, not Wired.

---
![fit original](images/other_wire.jpg)

^ OK, not THAT Wire.

---
# About Wire.

![left fit](images/logo.png)

- I am the part of the awesome iOS team at Wire.

^ Ah yeah! That one. I am the part of the awesome iOS team at Wire. 

---
# About Wire.

![left fit](images/logo.png)

- I am the part of the awesome iOS team at Wire.
- We are one of E2EE pioneers: first version released in 2015.

^ Wire is the fully end-to-end encrypted messenger platform. We are developing the secure and fun collaboration tool that you can use on all modern platforms. We where one of the pioneers of the end-to-end encryption, too.

---
# About Wire.

![left](images/win311logo.png)

- I am the part of the awesome iOS team at Wire.
- We are one of E2EE pioneers: first version released in 2015.
- Available as the team communication solution, too 🎉.

^ Since 2018 Wire is avilable as the team communication solution, too.

---

![left](images/finn-hackshaw-131930-unsplash.jpg)

# `github.com/wireapp`

^ Good news: we are also open-source, so you can see our bugs and how we are fixing them.

---
# It's live. Also PRs. 
## 400k SLOC Swift / Obj-C.
### GPLv3

^ Live, with the pull requests! Pretty awesome, also some pressure to work in the public. 

---
# How we proceed?

- Define what is good End to End Encryption.

^ First, let's start up by defining what the end to end enctyption is/

---
# How we proceed?

- Define what is good End to End Encryption.
- See what is necessary on iOS to keep it good.

^ Then understand what is necessary to do for the iOS developer to keep it that way.

---
# How we proceed?

- Define what is good End to End Encryption.
- See what is necessary on iOS to keep it good.
- Look into the future of the private messaging.

^ In the very end we are going to take a peek into the future of the private messaging. Let's go!

---
## So what is 
## End-To-End encryption, 
## exactly?

![fit](images/what-is-e2ee.png)

^ So what is the End-To-End encryption, exactly?

---
# Defining the problem.

```
		 Sender 🦊                       Receiver 🐸
		+--------+           ?                              
		|   💌   |  -------------------> 
		+--------+              
```

^ Let's first understand the problem. It's really easy to articulate. The _Sender_ would like to communicate with the receiver and send receiver a message.

---
# Defining the problem.

```
		 Sender 🦊                       Receiver 🐸
		+--------+           ?                              
		|   💌   |  -------------------> 
		+--------+              
```

# In the context.

![](images/nsa.png)

^ The first and the most basic constraint is that neither Sender, our foxy, nor the Receiver, our froggy, would like anyone else except the receiver to read the message, so the server does not know the message content. Other _significant_ constraint is that it is not possible for sender and receiver to meet and exchange the keys offline.

---
# Solution 🎉: Diffie-Hellman (DH) key exchange.

```
 Sender 🦊  <----- Public keys ----> Receiver 🐸
```
1. Sender and receiver generate the key pairs: $$(K^{Pub}_{🦊}, K^{Priv}_{🦊}), (K^{Pub}_{🐸}, K^{Priv}_{🐸})$$

^ Sure enough people familiar with the encryption would say that sender and receiver can use the public key crypto to exchange the public key information to generate the shared secret. They both, the sender and the receiver, generate the key pairs: public and private keys. 

---
# Solution 🎉: Diffie-Hellman (DH) key exchange.

```
 Sender 🦊  <----- Public keys ----> Receiver 🐸
```
1. Sender and receiver generate the key pairs: $$(K^{Pub}_{🦊}, K^{Priv}_{🦊}), (K^{Pub}_{🐸}, K^{Priv}_{🐸})$$
2. Exchange: $$📱_{🦊} \xrightarrow[{K^{Pub}_{🦊}}]{} 🐸$$, $$📱_{🐸} \xrightarrow[{K^{Pub}_{🐸}}]{} 🦊$$

^ Then they exchange the public keys and based on those generate the shared secret.

---
# Public-key crypto.

Using the Diffie-Hellman (DH) procedure, the shared secret key is created: $$K^{Shared}_{🦊🐸} = DH(K_{🐸}, K_{🦊})$$

```
                    Secure channel
 Sender 🦊  <---- encrypted with the ----> Receiver 🐸
                   shared secret key
```

^ This is how TLS (and HTTPs over it) is working.

---
# Problem 1: Receiver not online ⚠️

![](images/wo_side_by_side.jpg)

Using the DH or RSA, both participants must be online in order to perform the key exchange.

This is not possible for reasons: phone or other device is not online.

^ Now here we have the first issue: if the message receiver is not online, it is not possible to start the key exchange. Also it is not feasible for the sender to wait for the receiver to go online.

---
# Solution.

- Receiver can publish his public key in advance to the server: $$📱_{🐸} \xrightarrow[{K^{Pub}_{🐸}}]{} 🌍$$.
- Sender can fetch it on demand: $$🌍 \xrightarrow[{K^{Pub}_{🐸}}]{} 📱_{🦊}$$.

^ The participant who might want to receive the encrypted message might upload his public key in advance to the server. Next time someone wants to communicate with him it is possible to fetch the public key from the server: easy!

---
## In Wire $$K^{Pub}_{🐸}$$ is called the _Prekey_.

![](images/richard-payette-522432-unsplash.jpg)

---
# Problem 2: Authenticity ⚠️

- What if someone generates another key pair: $$(K^{Priv}_{🦅}, K^{Pub}_{🦅})$$.
- Upload it to the server pretending he is 🐸: $$📱_{🦅} \xrightarrow[{K^{Pub}_{🦅}}]{} 🌍$$.

^ Oh come on, so we have come to another problem now: what if SOMEONE, let's say the eagle, replace the public key on the server with his or her own, and pretend to be our froggy?

---
# Problem 2: Authenticity ⚠️

- Anyone who would like to talk with 🐸 will actually create the shared secret with 🦅!
- Then 🦅 can decide to create the shared secret with 🦊 and relay the messages reading them.

^ This is actually quite possible to happen. The shared secret then would be created between the sender and the eagle. The Eagle would then be able to either create another secure channel with the receiver to relay the messages, or simply read and reply on the messages, impersonating the receiver.

---
# This is called ~~g~~man-in-the-middle attack.

```


 🦊  <-- Secure channel --> 🦅 <-- Secure channel --> 🐸
```
---
# Solution: Key Verification 🔑.

- It is possible to sign the key with another private key and verify the signature.

^ Lucky enough it is possible to sign the public key and verify the signature. However you need to always remember to receive the signature to compare against via the trusted communication channel.

---
# Solution: Key Verification 🔑.

- It is possible to sign the key with another private key and verify the signature.
- In HTTPs: the authority signatures (public keys) are saved in the keychain. 

---
# Solution: Key Verification 🔑.

- It is possible to sign the key with another private key and verify the signature.
- In HTTPs: the authority signatures (public keys) are saved in the keychain. 
- In messaging: users must check the key fingerprints of other party, via the call or meeting in person.

---
## In Wire 
## it is called 
## the _fingerprint verification_.

![](images/cmdr-shane-610506-unsplash.jpg)


---
# Problem 3: Forward secrecy.

- If the 🦅 would record all the encrypted communication between 🦊 and 🐸...

^ Let's imagine that our Eagle is recording the encrypted messages all the time to it's endless hard drives. 


---
# Problem 3: Forward secrecy.

- If the 🦅 would record all the encrypted communication between 🦊 and 🐸...
- And then find out the $$K^{Shared}_{🦊🐸}$$.
- All the previous communication can be decrypted.

^ Then if eventually it would be possible to decrypt one message from the communication between the sender and receiver, it would be possible using the same key to decrypt all the previous messages. This is pretty bad!

---
# Solution: Session keys / Key rotation.

## Generate the new key for each message:

- Rotate using Hash Key Derivation Function (HKDF) - basically hash the previous key: $$K^{n}_{🦊🐸} = HKDF(K^{n-1}_{🦊🐸})$$
- Can't calculate $$K^{n-1}_{🦊🐸}$$ from $$K^{n}_{🦊🐸}$$.

^ So again lucky enough we can do the following trick: let's hash the shared secret every time we encrypt the message. Then the receiver can also hash his key and decrypt the message. The good salted hash function is really hard to invert, so we can be safe again! Uh.

---
# Problem 4: Backward / Future secrecy.

- If 🦅 would find out the $$K^{n}_{🦊🐸}$$...
- He can $$HKDF$$ it, too, and find out the next key $$n+1$$.

^ But again, it is easy to advance the hash forward, so the intruder once he or she finds out one key number n, it is also possible to advance the key forward, and then it is possible to continue reading the communication from that message on.

---
# Solution: DH re-negotiation, mixing the initial session keys with the new ones.

- Every message we send, we also include the new public key signed with our initial session key.
- Receiver also generate another key pair and restart the session.

^ To fix that we can when sending the message include the new signed prekey, so the receiver can generate the new Diffie-Hellman shared secret. The intruder cannot do that, since he or she cannot sign the new prekey.

---
# Problem 5: It's not me i.e. _Plausible Deniability_.

- Remember problem 2: Authenticity?
- It is good to check if the person talking to you is the one you want to talk to.
- It is also possible to say that only the sender can sign the message, since only sender has his private key.

^ So you remember this problem when we wanted to check who is really the sender? It is good to have, but this has one downside: you can also associate the sender with the message, which has some implications.

---
# Plausible Deniability

- So what's the issue here?
- It is possible to associate the message with the sender.
- Can be the proof in the court 👨‍⚖️: message is signed by the sender!

^ So, what is the problem with associating the message with the sender? This has the downside: sometimes it is not good to be able to identify the sender, for example if you are in-mated, the dissident, trying to discuss the future of your country in the private chat. 

---
# Solution: Derive signing keys from the shared key.

- Derive the signing MAC key from the _shared secret_.
- Roll it forward after each DH re-negotiation.
- Both participants are able to create the signed message.

^ So the great idea here is to derive the signing key from the shared secret, that is known to both sender and the receiver. Then it is possible for both participants to sign the message with the same MAC key, and it is not possible to say who signed the particular message. It's all good, but...

---
# All good.
# In theory.

![left](images/katya-austin-554633-unsplash.jpg)

^ All good in theory.

---
# Cruel reality:

## having the screenshot of the message is enough for the attribution.

^ Here comes the cruel reality: having the screenshot of the message is usually enough for the attribution.

---
# Why good E2EE was not available earlier?

- No good protocol to solve problems 3-5.
- The performance of the key pair $$(K^{Pub}, K^{Priv})$$ generation improved dramatically, since:
- Elliptic curve crypto development.
- Mobile CPUs are way faster nowadays .

^ So you might wonder why the good end-to-end messengers became available only recently? Well, all those problems where not solved at once, the protocol development went the long way from PGP, Off-the-record protocol and others. Together with that, the performance of the cryptography also went the long way to the current state.

---
# Recap: good E2EE is:

1. Confidentiality.
1. Authenticity.
1. Forward Secrecy.
1. Backward (Future) Secrecy.
1. Plausible Deniability.

^ Just to recap, the GOOD end-to-end encryption must have those five qualities: Confidentiality, Authenticity, Forward Secrecy, Backward or Future Secrecy and the Plausible Deniability.

---
## The Wire protocol that solves problems 1-5 is called _Proteus_.

^ The Wire protocol that solves problems 1-5 is called _Proteus_.

---
# But...

---
### Even the best protocol cannot protect from iTunes backup ;)

^ Even the best protocol cannot protect from iTunes backup ;)

---
# iTunes and iCloud backups.

- The content of the backup is stored plaintext in the iTunes or (even worse) in the iCloud.
- Since we care not to put user data on our backend, we also have to care not to put it on the Apple backend.

^ The content of the backup is stored plaintext in the iTunes or (even worse) in the iCloud. Since we care not to put user data on our backend, we also have to care not to put it on the Apple backend.

---
# iTunes and iCloud backups.

Like that[^1]: 

```swift
var resourceValues = URLResourceValues()
resourceValues.isExcludedFromBackup = true
try mutableURL.setResourceValues(resourceValues)
```

[^1]: Source: https://github.com/wireapp/wire-ios/blob/develop/WireExtensionComponents/Utilities/URL%2BBackup.swift

^ So let's exclude the sensitive files, like the message database or the key material from the iTunes backup. This can be achieved using the URLResourceValues object having isExcludedFromBackup set to true that can be set on the file URL.

---
# Image, Video metadata.

![left](images/rawpixel-369775-unsplash.jpg)

Every image or video taken on the iPhone has a significant amount of embedded metadata:
- Device location 📍.
- Model 📱.
- Camera information 📷.

^ Every image or video taken on the iPhone has a significant amount of embedded metadata, including the device location, model and the camera information. This is not the information you usually think you are sharing when you upload the picture.

---
# Strip metadata using `ImageIO`.

Load image from `Data` to `imageSource` [^2]:

```swift
guard let imageSource = CGImageSourceCreateWithData(data, nil),
      let type = CGImageSourceGetType(imageSource) else {
    throw MetadataError.unknownFormat
}
```

[^2]: Source: https://github.com/wireapp/wire-ios-images/blob/develop/Sources/Image%20Processing/NSData+MediaMetadata.swift

^ Let's strip this information before uploading it. The ImageIO framework can help us with this task. We have the image as Data, and we can create the CoreGraphics image from it as imageSource.

---
# Strip metadata using `ImageIO`.

Create the new image `imageDestination`:

```swift
let count = CGImageSourceGetCount(imageSource)
let mutableData = NSMutableData(data: self as Data)
guard let imageDestination = CGImageDestinationCreateWithData(mutableData,
                                                              type, 
                                                              count, 
                                                              nil) else {
	throw MetadataError.cannotCreate
}
```

^ Then we can create the new image destination.

---
# Strip metadata using `ImageIO`.

Reset the metadata:

```swift
for sourceIndex in 0..<count {
    CGImageDestinationAddImageFromSource(imageDestination, 
                                         imageSource, 
                                         sourceIndex, 
                                         nullMetadataProperties)
}

guard CGImageDestinationFinalize(imageDestination) else {
    throw MetadataError.cannotCreate
}
```

^ And finally create the new image data excluding the metadata.

---
# CallKit.

- CallKit used to sync the calls metadata between the devices.
- iOS 11 fixed that.

^ When the CallKit was introduced, it used to sync the calls metadata between the devices. So call information also went to Apple backend.

---
# Push Notifications (APNs) 💔 E2EE.

- The message sent via the push notification is visible to Apple.

^ So let's talk about the push notifications. First of all, the wire backend does not know the message content, or even what kind of message must be sent. So it cannot really include the message text in the push notification.

---
# Push Notifications (APNs) 💔 E2EE.

- The message sent via the push notification is visible to Apple.
- APNs allows sending the "VoIP APN".
- Using **VoIP** push, the iOS application can run the code in the background, then it can fetch messages and display the local push.

^ Lucky enough, there is the way for the end-to-end encrypted app to be able to dispatch the notification. We can send the VoIP push notification with the PushKit. Using this kind of push, the iOS application can run the code in the background, then it can fetch messages and display the local push.

---

```
+--------+              +---------+      +-----------+      +----------+
| Sender |              |  Your   |      | APN Apple |      | Receiver |
|        |              | Backend |      |  Backend  |      |          |
+---+----+              +----+----+      +-----+-----+      +----+-----+
    |     Encrypted          |                 |                 |
    +--message for Receiver->|                 |                 |
```

^ So we have our sender, receiver, our backend and apple push backend. We start from the momen the sender is delivering the encrypted message payload to the server.

---

```
+--------+              +---------+      +-----------+      +----------+
| Sender |              |  Your   |      | APN Apple |      | Receiver |
|        |              | Backend |      |  Backend  |      |          |
+---+----+              +----+----+      +-----+-----+      +----+-----+
    |     Encrypted          |                 |                 |
    +--message for Receiver->|                 |                 |
    |                        |                 |                 |
    |                        +--- VoIP APN --->|                 |             
    |                        |                 |                 |
    |                        |                 +--- VoIP APN --->BG
```

^ The backend cannot see the content of the message, so it is dispatching the empty voip notification to the receiver via the apple push backend.

---

```
+--------+              +---------+      +-----------+      +----------+
| Sender |              |  Your   |      | APN Apple |      | Receiver |
|        |              | Backend |      |  Backend  |      |          |
+---+----+              +----+----+      +-----+-----+      +----+-----+
    |     Encrypted          |                 |                 |
    +--message for Receiver->|                 |                 |
    |                        |                 |                 |
    |                        +--- VoIP APN --->|                 |             
    |                        |                 |                 |
    |                        |                 +--- VoIP APN --->BG
    |                        |                 |                 BG
    |                        |<--- Fetching the new messages ---+BG
```

^ Then the receieving application is started on the background and it is reachig the bakcend to fetch the encrypted message payload.

---

```
+--------+              +---------+      +-----------+      +----------+
| Sender |              |  Your   |      | APN Apple |      | Receiver |
|        |              | Backend |      |  Backend  |      |          |
+---+----+              +----+----+      +-----+-----+      +----+-----+
    |     Encrypted          |                 |                 |
    +--message for Receiver->|                 |                 |
    |                        |                 |                 |
    |                        +--- VoIP APN --->|                 |             
    |                        |                 |                 |
    |                        |                 +--- VoIP APN --->BG
    |                        |                 |                 BG
    |                        |<--- Fetching the new messages ---+BG
    |                        |                 |                 |
    |                        |                 |             +-Display-+
    |                        |                 |             |  Local  |
    |                        |                 |             +--Push---+
```

^ To decrypt it and display the local push notification.

---
# Problems.

- If app cannot manage to fetch and decrypt the message in time, the push notifications are not going to be delivered.
- If the receiver is offline, then the APN scheduler can drop some notifications, so no chance to fetch messages.

^ But this comes with the cost: the VoIP push has the very short time to live, also the run time in the background is limited. If the client cannot manage to fetch the message content from the backend in time, the push notifications are not going to be delivered. Also if the receiver is offline, then the APN scheduler can drop some notifications, so client has no chance to fetch the messages.

---
# Possible solution: Background Fetch.

- It is possible to enable the background fetching, so when the device comes online the app would have the chance to fetch messages.


```swift
application.setMinimumBackgroundFetchInterval(timeInterval)
```

^ Lucky enough we can ask iOS to wake our app time to time to fetch the message from the backend, if any.

---
# Share Extensions 💔💔💔 E2EE.

- On iOS, the share extension is the separate process.
- Database and the crypto material must be moved to the shared container.
- File sync is necessary: read up here [^3].

[^3]: https://medium.com/@wireapp/the-challenge-of-implementing-ios-share-extension-for-end-to-end-encrypted-messenger-dd33b52b1e97

^ Another big topic is the share extensions. They on iOS are running in the separate process. The problem is then the crypto material and the app database must be then moved to the shared container. The file access must be synchronized, since the encryption of the message is advancing the encryption session forward.

---
# Big chats 🤕 E2EE.

![](images/joel-filipe-260016-unsplash.jpg)

- The message must be delivered to each participant.

^ In the group chat, if someone is sending the message it must be encrypted for each receiver separately. 

---
# Big chats 🤕 E2EE.

![](images/joel-filipe-260016-unsplash.jpg)

- The message must be delivered to each participant.
- To the each participant's device!

^ Also worth mentioning that in Wire we have the true multi-device support. This means each device has the encryption session with all participants in the chat.  

---
# Big chats 🤕 E2EE.

![](images/joel-filipe-260016-unsplash.jpg)

- The message must be delivered to each participant.
- To the each participant's device!
- So when you send one message, say 1 Kilobyte of data in the conversation with N participants where each participant has K devices you actually have to send $$ 1 Kilobyte \times N \ times K $$ messages.
- 100 participants, each have 5 devices: **0.5 Megabyte**.

^ This means that in the really big conversation sending 1 kilobyte message means uploading 500 kilobyte of data.

---
# Sneak peek: MLS.

- MLS is `Messaging Layer Security`.

^ So there is something that I am really excited about. The new state of the art protocol is being developed. The new state of the art protocol called Messaging Layer Security.

---
# Sneak peek: MLS.

- MLS is `Messaging Layer Security`.
- IETF initiative to develop the common protocol for secure instant messaging.
- ...in cooperation between Twitter, Mozilla, Google, Facebook and Wire.


^ Twitter, Mozilla, Google, Facebook and Wire as part of the IETF initiative are working together to define the future of the messaging. This can become in the future IETF standard.

---
# MLS: Stay tuned!

- Improves the message sending in the big (>100) group conversations.
- One standard that can potentially unify the different messengers.
- [https://www.ietf.org/mailman/listinfo/MLS](https://www.ietf.org/mailman/listinfo/MLS)
- [https://datatracker.ietf.org/doc/draft-omara-mls-architecture/](https://datatracker.ietf.org/doc/draft-omara-mls-architecture/)
- [https://github.com/facebookresearch/asynchronousratchetingtree](https://github.com/facebookresearch/asynchronousratchetingtree)

^ This can be potentially used to make different messengers be able to communicate with each other. They found also the smart way to overcome the group chat size limitation. Would be really interesting to see where it is going in the future, if IETF would approve it as the standard.

---
# Hope you enjoyed it!

^ Hope you enjoyed it! Let's build together the future where it is possible to communicate privately thanks to technology.

---
# Thanks!

[Wire Security Whitepaper](https://wire-docs.wire.com/download/Wire+Security+Whitepaper.pdf)

![inline](images/gh.png) [github.com/mikeger](github.com/mikeger)

![inline](images/twitter.png) [twitter.com/GerasimenkoMiha](twitter.com/GerasimenkoMiha)

![inline](images/cc_4_0.png) ![inline](images/cc.png) Presentation is CC BY 4.0 [mikeger/e2ee-presentation](https://github.com/mikeger/e2ee-presentation)

Illustrations: Wired magazine, HBO; Unsplash: Katya Austin, rawpixel, Richard Payette, Joel Filipe, CMDR Shane, Finn Hackshaw.
