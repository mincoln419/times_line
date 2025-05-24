package org.mermer.todoapi.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QDailyTimeline is a Querydsl query type for DailyTimeline
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QDailyTimeline extends EntityPathBase<DailyTimeline> {

    private static final long serialVersionUID = -943711347L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QDailyTimeline dailyTimeline = new QDailyTimeline("dailyTimeline");

    public final QBaseEntity _super;

    //inherited
    public final DateTimePath<java.time.LocalDateTime> createAt;

    // inherited
    public final QTimeUser createdBy;

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final ListPath<TodoItem, QTodoItem> items = this.<TodoItem, QTodoItem>createList("items", TodoItem.class, QTodoItem.class, PathInits.DIRECT2);

    public final DatePath<java.time.LocalDate> timelineDate = createDate("timelineDate", java.time.LocalDate.class);

    public final QTimeUser timeUser;

    //inherited
    public final DateTimePath<java.time.LocalDateTime> updateAt;

    public QDailyTimeline(String variable) {
        this(DailyTimeline.class, forVariable(variable), INITS);
    }

    public QDailyTimeline(Path<? extends DailyTimeline> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QDailyTimeline(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QDailyTimeline(PathMetadata metadata, PathInits inits) {
        this(DailyTimeline.class, metadata, inits);
    }

    public QDailyTimeline(Class<? extends DailyTimeline> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this._super = new QBaseEntity(type, metadata, inits);
        this.createAt = _super.createAt;
        this.createdBy = _super.createdBy;
        this.timeUser = inits.isInitialized("timeUser") ? new QTimeUser(forProperty("timeUser")) : null;
        this.updateAt = _super.updateAt;
    }

}

