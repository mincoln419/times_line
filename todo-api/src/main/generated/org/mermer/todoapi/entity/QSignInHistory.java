package org.mermer.todoapi.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QSignInHistory is a Querydsl query type for SignInHistory
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QSignInHistory extends EntityPathBase<SignInHistory> {

    private static final long serialVersionUID = -1508515707L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QSignInHistory signInHistory = new QSignInHistory("signInHistory");

    public final StringPath id = createString("id");

    public final DateTimePath<java.time.LocalDateTime> signInAt = createDateTime("signInAt", java.time.LocalDateTime.class);

    public final QTimeUser timeUser;

    public QSignInHistory(String variable) {
        this(SignInHistory.class, forVariable(variable), INITS);
    }

    public QSignInHistory(Path<? extends SignInHistory> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QSignInHistory(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QSignInHistory(PathMetadata metadata, PathInits inits) {
        this(SignInHistory.class, metadata, inits);
    }

    public QSignInHistory(Class<? extends SignInHistory> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this.timeUser = inits.isInitialized("timeUser") ? new QTimeUser(forProperty("timeUser")) : null;
    }

}

