import { createServer } from "http";
import express from "express";
import { ApolloServer, gql } from "apollo-server-express";
import { prisma } from "./prisma/client";

const startServer = async () => {
  const app = express();
  const httpServer = createServer(app);

  const typeDefs = gql`
    type Query {
      users: [User]
    }

    type User {
      id: ID!
      email: String
      country_code: String
      phone: String
      version: Int
      role: String
      bio: String
      master: Master
    }

    type Master {
      id: ID!
      first_name: String
      last_name: String
      avatar: String
      language: Language
      city: City
      work_at_master: Boolean
      work_at_customer: Boolean
      work_with_women: Boolean
      work_with_men: Boolean
      profile_url: String
      user: User
    }

    type Language {
      id: ID
      key: String
      name: String
      name_ua: String
      name_ru: String
      name_pl: String
      flag_url: String
    }

    type City {
      id: ID!
      country: Country
      name: String
      name_ua: String
      name_ru: String
      name_pl: String
      coord: Float
      flag_url: String
    }

    type Country {
      id: ID!
      name: String
      name_ua: String
      name_ru: String
      name_pl: String
      flag_url: String
    }
  `;

  const resolvers = {
    Query: {
      users: () => {
        return prisma.user.findMany({
          where: {
            email: {
              contains: 'markos',
            }
          },
          include: {
            master: {
              include: {
                language: true,
                city: {
                  include: {
                    country: true
                  }
                }
              }
            },
          },
        })
      }
    },
  };

  const apolloServer = new ApolloServer({ typeDefs, resolvers })

  await apolloServer.start()

  apolloServer.applyMiddleware({ app, path: `/api` })

  httpServer.listen({ port: process.env.PORT || 4000 }, () =>
    console.log(`Server listening on localhost:4000${apolloServer.graphqlPath}`)
  )
}

startServer()